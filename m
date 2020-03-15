Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857AE185E70
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 17:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgCOQTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 12:19:04 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50929 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgCOQTE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 12:19:04 -0400
Received: by mail-io1-f70.google.com with SMTP id d16so10045647iop.17
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2020 09:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aBVpr2lszHHXRhoIRtyr/UgZ7zigQ1Re4Bzqf5rEmB8=;
        b=KGx3ZHdGjFr3zFZLkktLuE/urARQsXgkkJLlxIf8Fu5vF4CVqOw4TxEQVHgZajKco0
         EEhlFyjvEk7GOrspQwBC1XMqeWi5HukBI4LBp8kvbWGJVN0VPVOgGqa/j0FhCrlIoRQq
         COPlfXieAg8YTLlxMErdFbLeS5nHSv8U50rDFjqNI8mVMkN7LphVa3zJXNQDk/Sy7YuA
         H4AIySFbCenkt1jqY+4kEFYo8VkydXmraGzy1jg7EA9heFmx52+OuFxx3zqOU/PTRb6o
         9XkkffLlgOyCvDfbVnhsq450QnTVfJhB4kXGOxM2AH9Wo+FlwK1XCcZyFNC5LDIMiixC
         YFAQ==
X-Gm-Message-State: ANhLgQ2i6IqQk7v40QNPYoiL3jT/AKDMn62eJT2+XGM/OYWyfuXlwfVr
        nlRNXbmwuTk5WYeGIPF+rZNY6l9R65Uu/fQPQ9aD7fWSKISV
X-Google-Smtp-Source: ADFU+vvEpKjTJKXQNX4cXiEk/M0vqZw0uACkxtFRoJsmPwDzy61qIqim7f8/xuwV9rHXdGAII/j6tBy3274dpYif2g5SMTDAgQSk
MIME-Version: 1.0
X-Received: by 2002:a92:3b11:: with SMTP id i17mr18499810ila.161.1584289143334;
 Sun, 15 Mar 2020 09:19:03 -0700 (PDT)
Date:   Sun, 15 Mar 2020 09:19:03 -0700
In-Reply-To: <000000000000fb27f1059aa202ea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c33d905a0e70f63@google.com>
Subject: Re: possible deadlock in pipe_lock (3)
From:   syzbot <syzbot+217d60b447573313b211@syzkaller.appspotmail.com>
To:     jencce.kernel@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 1a980b8cbf0059a5308eea61522f232fd03002e2
Author: Murphy Zhou <jencce.kernel@gmail.com>
Date:   Fri Jan 17 12:49:29 2020 +0000

    ovl: add splice file read write helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12dd7dc3e00000
start commit:   46cf053e Linux 5.5-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=217d60b447573313b211
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116496c1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10104649e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: ovl: add splice file read write helper

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
