Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8575F98BC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 08:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfHVG4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 02:56:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54722 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfHVG4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:56:10 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7M6tWIW029585;
        Thu, 22 Aug 2019 15:55:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Thu, 22 Aug 2019 15:55:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7M6tVCG029581;
        Thu, 22 Aug 2019 15:55:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x7M6tVmv029579;
        Thu, 22 Aug 2019 15:55:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201908220655.x7M6tVmv029579@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on sockets.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp,
        "David S. Miller" <davem@davemloft.net>
MIME-Version: 1.0
Date:   Thu, 22 Aug 2019 15:55:31 +0900
References: <8f874b03-b129-205f-5f05-125479701275@i-love.sakura.ne.jp> <20190822063018.GK6111@zzz.localdomain>
In-Reply-To: <20190822063018.GK6111@zzz.localdomain>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers wrote:
> What happened to this patch?

I have to learn how to manage a git tree for sending
pull requests, but I can't find time to try.

> 
> Also, isn't the same bug in other places too?:
> 
> 	- tomoyo_path_chmod()
> 	- tomoyo_path_chown()
> 	- smack_inode_getsecurity()
> 	- smack_inode_setsecurity()

What's the bug? The file descriptor returned by open(O_PATH) cannot be
passed to read(2), write(2), fchmod(2), fchown(2), fgetxattr(2), mmap(2) etc.
