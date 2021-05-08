Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22AE376ED6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 May 2021 04:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhEHCgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 22:36:17 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:40678 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEHCgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 22:36:16 -0400
Received: by mail-il1-f197.google.com with SMTP id d3-20020a056e021c43b029016bec7d6e48so8710315ilg.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 May 2021 19:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yRpfOOpyTTcZNtaZ5IFA1pZLlVZkx0zucBbPg4TfvcI=;
        b=LOpa0559JaL/IEQRJ6zkoTx0SGfe8BTihmshaIGE/pofdb6Ta/ZITyIvXfusXzbQt2
         ovZrhOGR7kFSAyjU9PDb0Qzc4bIyn7aXovZPhS8vK+h5B/jq7a19L+cNqOq/9rCExuR4
         ecY2cfrQU1IF2LHk/KCuxaJfbe8MsCMPlkfwVTArGkGRGRXFBREN+oTpwQMLtNBmBxWC
         xbqfPVwLwLjUhtAplvyjxoOVWnF9m8p4H8v6qqDrGAsmt6Tb1WVJMLhud/4ql/eStlPJ
         RI6xs+dgtIe+sNAwoBqR3V9f60m6qU36x2eInOeaLXhDmexMuexDgDiDuiQjn1yx7G+6
         kptA==
X-Gm-Message-State: AOAM531wJSFA49lYZBAplN8PVAzow0AXGJk/9bmU1GmFmSsy8nd8CvF4
        JtivBMR/Zs3e6G2ZrI7A271zM9aIJ56j54HG77NM0FPlsRUS
X-Google-Smtp-Source: ABdhPJzHX9c5ZG3/8fGP0JaqYE7j0K8Z0eec2LcJ8r2KtTJmomlFxyYd/fHhv36H4CjE56fnpZb8C22cwsFriCp5qltYrQjG8+au
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr11998791ils.93.1620441315987;
 Fri, 07 May 2021 19:35:15 -0700 (PDT)
Date:   Fri, 07 May 2021 19:35:15 -0700
In-Reply-To: <c2cab9a3-b821-e4fa-3a8a-c66f15a642c3@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004f05705c1c86547@google.com>
Subject: Re: [syzbot] INFO: task hung in __io_uring_cancel
From:   syzbot <syzbot+47fc00967b06a3019bd2@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+47fc00967b06a3019bd2@syzkaller.appspotmail.com

Tested on:

commit:         50b7b6f2 x86/process: setup io_threads more like normal us..
git tree:       git://git.kernel.dk/linux-block io_uring-5.13
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e1cf8ad694ca2e1
dashboard link: https://syzkaller.appspot.com/bug?extid=47fc00967b06a3019bd2
compiler:       

Note: testing is done by a robot and is best-effort only.
