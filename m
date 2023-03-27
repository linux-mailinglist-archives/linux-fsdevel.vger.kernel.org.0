Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6614E6CA539
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 15:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjC0NKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 09:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjC0NKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:10:50 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809CC2116
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 06:10:45 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32RD9wVt038597;
        Mon, 27 Mar 2023 22:09:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Mon, 27 Mar 2023 22:09:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32RD9ljL038559
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Mar 2023 22:09:58 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d6f0c646-3dcb-ec68-ee0b-ba05704128db@I-love.SAKURA.ne.jp>
Date:   Mon, 27 Mar 2023 22:09:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] sysv: convert pointers_lock from rw_lock to rw_sem
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christian Brauner <brauner@kernel.org>
References: <0000000000000ccf9a05ee84f5b0@google.com>
 <6fcbdc89-6aff-064b-a040-0966152856e0@I-love.SAKURA.ne.jp>
 <20230327000440.GF3390869@ZenIV>
 <6bfca9e9-d4d8-37ec-d53c-0c77e7c70e85@I-love.SAKURA.ne.jp>
 <20230327130205.GG3390869@ZenIV>
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230327130205.GG3390869@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/03/27 22:02, Al Viro wrote:
> IOW, sysv_truncate() (as well as its minixfs counterpart) relies upon having
> serialization wrt other callers of sysv_truncate().

I see. Please submit a patch.

