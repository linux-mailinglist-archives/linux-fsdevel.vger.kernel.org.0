Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3B33C859F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 15:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhGNN5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 09:57:00 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:39536 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhGNN5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 09:57:00 -0400
Received: by mail-io1-f71.google.com with SMTP id v2-20020a5d94020000b02905058dc6c376so1272141ion.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 06:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5iBy0lYSGa09oNnLjcIT0TpubGTNL6rsWEE+k4WZlK0=;
        b=bSKaDMZYpHNjEQ2INc1CMLfWfI6hI2xj7Tho+/JVsYfZqjujaahBARO8w1FqBnCyno
         LGcB7lWXs3ZCxvIHMH9ZyO8dSurzJ6V/4CAHJEAZempJ8BlkbX7WizZ5XZteEcHjc1RV
         tytFeJm91Wm3F6gsbv9EfBrFcdP76mQ/wmk+OnhlfmEUsBfakB/n83sxWxlLRVfAcu53
         qVGv4fvSzpLHt7KHAKHbj8WqW1bU/VesGkzq4nJ6ieHuT0KH5RsHjupBVHHxW8dFrbv4
         otF0yHGT8UJz+h+g2uky+TJjXhMnWXaZhQDABVEvMkL5EGQi0UpsX1DOIJOP/97h462B
         5d5g==
X-Gm-Message-State: AOAM531DQxTCdCu5ERulEXOxoX712Jvr0Hbl3ipIe2Cf+/0joVHJ0sQ8
        GvrhG1zMpGdRUye69uDE0/7sTyuBQitLrYpL2BS2cWIn3heQ
X-Google-Smtp-Source: ABdhPJxdriFY6cRso6foqyHhWvZJZlr8sMQZFvXXGupXDK0NKiVdeKKS73K8wdaZOOY5jX5ldI66/IVlGmnDFv2tDrcjXqj1djd6
MIME-Version: 1.0
X-Received: by 2002:a92:360b:: with SMTP id d11mr6696974ila.111.1626270848535;
 Wed, 14 Jul 2021 06:54:08 -0700 (PDT)
Date:   Wed, 14 Jul 2021 06:54:08 -0700
In-Reply-To: <20210714135157.mz7utfhctbja4ilo@wittgenstein>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c529d05c715b0e3@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in filp_close (2)
From:   syzbot <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com>
To:     brauner@kernel.org, christian.brauner@ubuntu.com,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        gscrivan@redhat.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable-commits@vger.kernel.org,
        stable@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/ on commit 595fac5cecba71935450ec431eb8dfa963cf45fe: failed to run ["git" "checkout" "595fac5cecba71935450ec431eb8dfa963cf45fe"]: exit status 128
fatal: reference is not a tree: 595fac5cecba71935450ec431eb8dfa963cf45fe



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/ 595fac5cecba71935450ec431eb8dfa963cf45fe
dashboard link: https://syzkaller.appspot.com/bug?extid=283ce5a46486d6acdbaf
compiler:       

