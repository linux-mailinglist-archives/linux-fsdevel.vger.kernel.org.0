Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E42038016C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 03:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhENBGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 21:06:22 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:34597 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhENBGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 21:06:22 -0400
Received: by mail-io1-f69.google.com with SMTP id e84-20020a6bb5570000b029043a9371b108so517304iof.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 May 2021 18:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WyhwVb/2nAKSCjZePQHr7y74mXP0pKdra5nG2NU9qyo=;
        b=kQqKkc6tt/WAQDMYF/SZIOgYZMhm1/BL64auemotNsbKUmNoARUcTPYQ0pFhzPhjni
         HX2Kgl5avRY06/he8u4tojX+e2IyWo+HOE/v04o0UQ5+21iwtcB0g9ybIMGMMZrggJbB
         J/kpYzD4poeHxIOkPkPSlZnVLNaZiqBrDxjLfTuEVij+gVg73Yej3wkSRsCuDVLqIkAN
         +rTwPBvJkHYwO0qqncJ7k9ED2vydcIEo55Qxl665K3OaCBTrHOrutm6fuldJLm1XXoby
         WIxEitQ1PkcZy5wKdBIbjkpeWj1ExEAkC6qEJ8l0PxNY7Vg8gXF6AqFzLzLXvZmZ8dR+
         GrWg==
X-Gm-Message-State: AOAM5338nfpZ19O8CwKbH8rLo2Ylsx5UBpoGJOJASQnb+bZPM6V16aid
        TaDfthCgo36jWiaTkcpSx6ukX3KpOYy6CLSVHJYW3zuXy4vn
X-Google-Smtp-Source: ABdhPJzQ/Z36cpwXZM75ay+7M7e7JrJdMP6eFRSLZrA/471M4WuQmbzCyB4PZILkNutR+YB8DeBbVbSICSoaUPSnk/lGLMld8n6k
MIME-Version: 1.0
X-Received: by 2002:a02:cac6:: with SMTP id f6mr40166255jap.118.1620954311158;
 Thu, 13 May 2021 18:05:11 -0700 (PDT)
Date:   Thu, 13 May 2021 18:05:11 -0700
In-Reply-To: <314c4ece-d8c1-2d13-804b-3652488d09de@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9f47605c23fd526@google.com>
Subject: Re: [syzbot] WARNING in io_link_timeout_fn
From:   syzbot <syzbot+5a864149dd970b546223@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5a864149dd970b546223@syzkaller.appspotmail.com

Tested on:

commit:         b580b3d6 io_uring: always remove ltimeout on cb run
git tree:       https://github.com/isilence/linux.git syz_test8
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae2e6c63d6410fd3
dashboard link: https://syzkaller.appspot.com/bug?extid=5a864149dd970b546223
compiler:       

Note: testing is done by a robot and is best-effort only.
