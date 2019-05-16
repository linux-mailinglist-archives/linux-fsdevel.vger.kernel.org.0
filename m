Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D834A20701
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfEPMdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 08:33:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:52934 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfEPMdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 08:33:01 -0400
Received: by mail-io1-f70.google.com with SMTP id n82so2530787iod.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 05:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=r+Egu140poF9tk75Gappftvz+qoaAR2oEuAec5aF1lc=;
        b=em7nlLombuipd1MYcGsxvIcOMvddiwRa25kXSt6ZQR9PccJHDkyenl7A7hY0mDTvI0
         eOu2fKSEtYukW7dF/xEFQ6//G/H3/yaniRRATSQM60JvSYZ4mGmiAoGoN/c/a63e2Wbp
         GCv36cMtZfFitkHcVJCVrsJWgEdR83Q7ZCjnKwM6QsqurjWA4tl7b3hGfxfuxm1mWEtN
         W2jOixvDCBG6GbBaKqojwxuLIOh/4ZNvu86MD5+xcn3T/aA//L2NQOq1CT8UQtbIc29l
         v2rhCcsg38GogwBfIW6dWsLr5tkD0TOvDo+80MOU8O0wjIrEOdT5HOKEzK/dWXvqmIkV
         /6HA==
X-Gm-Message-State: APjAAAWPz97cjdzpCpxbaWmSx3QPHoB42+B/DwlyhJmij9K7J1xaGp1n
        bM5ADbQw+0yi6fZngfJO+KfAuXpAI4Um+uUrk9l3QnSO4Xpz
X-Google-Smtp-Source: APXvYqxi4qMlBgNoO/Oy+N4ls5yZp4lS3lRfW02dBfYXmkjFfsJ3hI2rbfbc0oB9b59/5ibzuynp9DYFx7tHwakcm80fTlZInRdf
MIME-Version: 1.0
X-Received: by 2002:a05:660c:2ce:: with SMTP id j14mr12523202itd.70.1558009980711;
 Thu, 16 May 2019 05:33:00 -0700 (PDT)
Date:   Thu, 16 May 2019 05:33:00 -0700
In-Reply-To: <20190516114817.GD13274@quack2.suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074f88405890077a3@google.com>
Subject: Re: INFO: task hung in __get_super
From:   syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dvyukov@google.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com

Tested on:

commit:         e93c9c99 Linux 5.1
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.1
kernel config:  https://syzkaller.appspot.com/x/.config?x=5edd1df52e9bc982
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=135c5b02a00000

Note: testing is done by a robot and is best-effort only.
