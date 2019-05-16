Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FBB206C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfEPMRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 08:17:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54496 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfEPMRw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 08:17:52 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4GCHI2r077140;
        Thu, 16 May 2019 21:17:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Thu, 16 May 2019 21:17:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4GCHBWG076893
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 16 May 2019 21:17:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in __get_super
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-block@vger.kernel.org
References: <0000000000002cd22305879b22c4@google.com>
 <201905150102.x4F12b6o009249@www262.sakura.ne.jp>
 <20190515102133.GA16193@quack2.suse.cz>
 <024bba2a-4d2f-1861-bfd9-819511bdf6eb@i-love.sakura.ne.jp>
 <20190515130730.GA9526@quack2.suse.cz>
 <20190516114817.GD13274@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ca1e5916-73ee-6fc4-1d78-428691f7fc64@i-love.sakura.ne.jp>
Date:   Thu, 16 May 2019 21:17:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516114817.GD13274@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/05/16 20:48, Jan Kara wrote:
> OK, so non-racy fix was a bit more involved and I've ended up just
> upgrading the file reference to an exclusive one in loop_set_fd() instead
> of trying to hand-craft some locking solution. The result is attached and
> it passes blktests.

blkdev_get() has corresponding blkdev_put().
bdgrab() does not have corresponding bdput() ?
