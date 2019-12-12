Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB6D11C5DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 07:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfLLGMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 01:12:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42068 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfLLGMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 01:12:09 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifHhm-0003fl-JM; Thu, 12 Dec 2019 06:12:06 +0000
Date:   Thu, 12 Dec 2019 06:12:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: corrupted list in __dentry_kill (2)
Message-ID: <20191212061206.GE4203@ZenIV.linux.org.uk>
References: <000000000000b6b03205997b71cf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b6b03205997b71cf@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:59:11PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    938f49c8 Add linux-next specific files for 20191211
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=150eba1ee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=96834c884ba7bb81
> dashboard link: https://syzkaller.appspot.com/bug?extid=31043da7725b6ec210f1
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dc83dae00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ac8396e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com

Already fixed in a3d1e7eb5abe3aa1095bc75d1a6760d3809bd672
