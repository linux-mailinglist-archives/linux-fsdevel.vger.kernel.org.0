Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481AF341ABE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 12:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhCSLCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 07:02:21 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37072 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhCSLCM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:02:12 -0400
Received: by mail-io1-f72.google.com with SMTP id a18so29758728ioo.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 04:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3kE9urkd9NS2DuoN7WUKMGk6xYQqlb0lhJPiUJGc07Q=;
        b=nR+BtJsC1GrWdCHFSmq9QtRQsneY7ZvoxoLyX08c2AiJjD50j4EEXfMC6XrDmwJaYF
         latF/S5KUa0B6PXCfZj09ilS37p2U6zUE8pmIZ4hJQpD1g446rYzOUTaYHyszYd7KIdT
         FZyydeiS2+3i095XBSCVtiShP9LQgppZMJ8+J5PJ0UavQ724XcX+Vk2I/Xmx03C3oGjO
         AcbTJnMNUz3hCnwv+2fmO5gkZHXIs1gLz1cpdLylyxZLlfx0Jr8E3cIilnStXJOVyH3z
         BepynMfkiRJvCwzTHKJWhRTy8VIVyH4bbnkw7A+oASEDLsHgSJpCU6NL8pDVfkLF04sQ
         Sw2A==
X-Gm-Message-State: AOAM533ibjulv9hrhyF5d9T4tKOogVPlnDswjEZ9qIEwr9/cY+uo0k6P
        4jnm+3hdv5PsO8YTS/lFbX0CPjM7h8M1hm4TW9SZ7RCxn0Nj
X-Google-Smtp-Source: ABdhPJz+kK4gMhywPYy9lQKtIKqExdj6dBXtuhCNKCvGyX4ec6P8xmes238+oDV+K8NqRw7qdQfcXpEuNSpryoDeSuUPHnN4TqSf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2141:: with SMTP id d1mr2302995ilv.85.1616151731732;
 Fri, 19 Mar 2021 04:02:11 -0700 (PDT)
Date:   Fri, 19 Mar 2021 04:02:11 -0700
In-Reply-To: <cd88eb14-f250-54d1-d36b-7af3917d3bec@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df888f05bde1a5b4@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in idr_for_each (2)
From:   syzbot <syzbot+12056a09a0311d758e60@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+12056a09a0311d758e60@syzkaller.appspotmail.com

Tested on:

commit:         ece5fae7 io_uring: don't leak creds on SQO attach error
git tree:       git://git.kernel.dk/linux-block io_uring-5.12
kernel config:  https://syzkaller.appspot.com/x/.config?x=28f8268e740d48dd
dashboard link: https://syzkaller.appspot.com/bug?extid=12056a09a0311d758e60
compiler:       

Note: testing is done by a robot and is best-effort only.
