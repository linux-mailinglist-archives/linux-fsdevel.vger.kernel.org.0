Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C505EDB91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 13:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiI1LQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 07:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiI1LQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:16:52 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C688A2604;
        Wed, 28 Sep 2022 04:16:44 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28SBG5TC026667;
        Wed, 28 Sep 2022 20:16:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Wed, 28 Sep 2022 20:16:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28SBG5DU026662
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Sep 2022 20:16:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e9d6a8fb-e3bb-19ea-8904-cf21bdc239d7@I-love.SAKURA.ne.jp>
Date:   Wed, 28 Sep 2022 20:16:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2] block: add filemap_invalidate_lock_killable()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        syzbot+39b75c02b8be0a061bfc@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <ff8f59e5-7699-0ccd-4da3-a34aa934a16b@I-love.SAKURA.ne.jp>
 <Ylzz0bbN1y3OFABI@infradead.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Ylzz0bbN1y3OFABI@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/04/18 14:14, Christoph Hellwig wrote:
> I'm starting to sound like a broken record as I'm stating it the third
> time now, but: 
> 
> no, this does not in any way fix the problem of holding the invalidate
> lock over long running I/O.  It just does ease the symptoms in the least
> important but apparently visible to you caller.
> 
> What we need to do is to get the zeroing I/O out from under the
> invalidate lock, just like how we don't do direct I/O under it.

No action was taken for 11 months since the first hung.
Christoph, when can you get to this work?

