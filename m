Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF931DCF36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 16:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgEUOJx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 10:09:53 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54504 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgEUOJw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 10:09:52 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04LE9Ikk073192;
        Thu, 21 May 2020 23:09:19 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Thu, 21 May 2020 23:09:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04LE9ImK073188
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 21 May 2020 23:09:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task hung in locks_remove_posix
To:     syzbot <syzbot+f5bc30abd8916982419c@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <000000000000c866c705a61a95d4@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <9a337dfa-175f-e13b-1977-0f63d589f37c@I-love.SAKURA.ne.jp>
Date:   Thu, 21 May 2020 23:09:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <000000000000c866c705a61a95d4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/05/21 5:53, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    806d8acc USB: dummy-hcd: use configurable endpoint naming ..
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=16c9ece2100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d800e9bad158025f
> dashboard link: https://syzkaller.appspot.com/bug?extid=f5bc30abd8916982419c
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.

This seems to be a mislabeling due to '?' in all lines in a trace.

#syz dup: INFO: task hung in wdm_flush
