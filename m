Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287AF3987E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 13:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhFBLVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 07:21:00 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:47745 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhFBLU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:20:58 -0400
Received: by mail-il1-f197.google.com with SMTP id c2-20020a92d3c20000b02901d9fda18626so1278921ilh.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jun 2021 04:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=Ik+ck8Lh3RRt0JEN5CCsrhUxXANYahmCllH+5HG5l88=;
        b=l5PsDTT+MdGlQIMzkGJIKRZODtJGJeDixnIEf9kFtdRsjKb/5cxcxxvCLLXUhYHO2F
         9qOTorlkW9T8D89l2DzALLdqqajP4YfUBCi8Xn2qzOrj31sCSRy3+YgqWIEE5d2Hvtyd
         Iy8gUOMxUJfvqh9qv5oCPOyxDq/w/+jwC3FVMvbZ6Vl0OLbRGQNM9gjCdeooI8DgibP2
         l7nqxLHwUW/yod86ENZmWNi7pbvdP6OHHaDmuaB6Q1d774f2rzzhlzEHlSFuSehbNf/1
         gor1tfil7aW8TIqm7lxsQTRfDBxjWX7G3qJ0JhRcBZUWVcOcuIdiXmPGm8J5sACzv1ci
         WaIg==
X-Gm-Message-State: AOAM532gknWUNlg75yagCsMkTH44VP51/gEpcGGkEY8nlUAaD7AHQ2JM
        QpXvqhLPfkV2i1WGa3rjtnLKRSt33PKgfczyutFQuxBIAzrC
X-Google-Smtp-Source: ABdhPJzJqVr2YzcOaqu2A0rRUEiRWN4jO2zCOcyJJKUMnlEYYcW6KSke3zHcDGUZQpzoXUdx3YpvAjjRKi+XPGZ3ZP0DqITYqcT4
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a9:: with SMTP id h9mr8555710ilo.96.1622632755758;
 Wed, 02 Jun 2021 04:19:15 -0700 (PDT)
Date:   Wed, 02 Jun 2021 04:19:15 -0700
In-Reply-To: <YLdo77SkmGLgPUBi@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000020d4a05c3c6a1bd@google.com>
Subject: Re: [syzbot] WARNING in idr_get_next
From:   syzbot <syzbot+f7204dcf3df4bb4ce42c@syzkaller.appspotmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     anmol.karan123@gmail.com, bjorn.andersson@linaro.org,
        coreteam@netfilter.org, davem@davemloft.net, dsahern@kernel.org,
        ebiggers@google.com, ebiggers@kernel.org, eric.dumazet@gmail.com,
        fw@strlen.de, kadlec@netfilter.org, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        necip@google.com, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> #syz fixed qrtr: Convert qrtr_ports from IDR to XArray

unknown command "fixed"

>
> On Wed, Jun 02, 2021 at 03:30:06AM -0700, syzbot wrote:
>> syzbot suspects this issue was fixed by commit:
>> 
>> commit 43016d02cf6e46edfc4696452251d34bba0c0435
>> Author: Florian Westphal <fw@strlen.de>
>> Date:   Mon May 3 11:51:15 2021 +0000
>
> Your bisect went astray.
>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/YLdo77SkmGLgPUBi%40casper.infradead.org.
