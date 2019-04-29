Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626D9DB8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 07:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfD2FgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 01:36:02 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:52929 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfD2FgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 01:36:01 -0400
Received: by mail-it1-f200.google.com with SMTP id 73so8704248itl.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2019 22:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3oF4+oEYyzAK0lmDHIO2D2jMP56B/wkYH6h2bOwtiuk=;
        b=g98ZrtxRms31Mo/nK2QjBoXRENV0F8VzAsoqYMoBJJbLdJZSIVmMh/HZEk6hxDi8JW
         Ew6Qvu99x3MvZyfTVACkoEtKTulO4Dgo+4jFUrCLGjMfX9xeXDL1WkuPexZmgVfShAm0
         UzfGad21rgMI2DzTx4nRMgpV19apyp9TOctHccU5SH87tGFjAnmqn0BOChKQF/lNK3HD
         HoH9Jxzo1xSPnuBwFV5UblYcGUcXZSwB4dysrYnbwCZjQmvthDBtISLovqL1qK0HVlee
         Nq7MbkeZlZXZWtE1nszqYQEcLi8ChNaBqxFac2TuYEAGuel4ZCtftlZRuzxv3igFuAtB
         tVfA==
X-Gm-Message-State: APjAAAUu821jM8bjUyVGk40Kn5IPtZAaCCtbdquAPFkGgLaBgSck83ha
        JVtWnwPz6lUzjXEVqlG78hPEzQYnA2nEE90px1+IKVOORkEp
X-Google-Smtp-Source: APXvYqxAbd7inE54NKKA41ooTkUqRm9jbppXNucHcGQfURYA7C+U0uUHQ41zM5uD2MQe0Q1gNW6Zt1FsTc19tDgmuKaSE6eizrUq
MIME-Version: 1.0
X-Received: by 2002:a6b:6405:: with SMTP id t5mr23042078iog.190.1556516160955;
 Sun, 28 Apr 2019 22:36:00 -0700 (PDT)
Date:   Sun, 28 Apr 2019 22:36:00 -0700
In-Reply-To: <20190429021039.GB29678@quack2.suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc6b2d0587a4a87f@google.com>
Subject: Re: general protection fault in fanotify_handle_event
From:   syzbot <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com

Tested on:

commit:         b1da6a51 fsnotify: Fix NULL ptr deref in fanotify_get_fsid()
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
kernel config:  https://syzkaller.appspot.com/x/.config?x=a42d110b47dd6b36
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
