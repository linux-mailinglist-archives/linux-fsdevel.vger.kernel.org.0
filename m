Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868B812B78
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 12:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfECKaI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 06:30:08 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58063 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECKaI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 06:30:08 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x43ATVk1042216;
        Fri, 3 May 2019 19:29:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Fri, 03 May 2019 19:29:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x43ATQ3O042117
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 3 May 2019 19:29:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in __get_super
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        axboe@kernel.dk, dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <001a113ed5540f411c0568cc8418@google.com>
 <0000000000002cd22305879b22c4@google.com>
 <20190428185109.GD23075@ZenIV.linux.org.uk>
 <20190430025501.GB6740@quack2.suse.cz>
 <20190430031144.GG23075@ZenIV.linux.org.uk>
 <20190430130739.GA11224@quack2.suse.cz>
 <20190430131820.GK23075@ZenIV.linux.org.uk>
 <20190430150753.GA14000@quack2.suse.cz>
 <aa220178-58d8-ffb7-399b-1d04e92e916f@i-love.sakura.ne.jp>
Message-ID: <71265ac6-c127-838f-d129-a9a95f755ecf@i-love.sakura.ne.jp>
Date:   Fri, 3 May 2019 19:29:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <aa220178-58d8-ffb7-399b-1d04e92e916f@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/05/01 0:34, Tetsuo Handa wrote:
> I still cannot understand what the problem is.
(...snipped...)
> I guessed that something went wrong with 8083 inside __getblk_gfp().
> How can loop_ctl_mutex be relevant to this problem?
> 

syzbot got similar NMI backtrace. No loop_ctl_mutex is involved.

INFO: task hung in mount_bdev (2)
https://syzkaller.appspot.com/bug?id=d9b9fa1428ff2466de64fc85256e769f516cea58
