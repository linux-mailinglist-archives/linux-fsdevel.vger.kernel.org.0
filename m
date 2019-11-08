Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC15F587F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 21:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfKHU0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 15:26:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37350 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHU0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:26:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id l21so210729ljg.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 12:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMlK7Upw2ce5Zg7xMf34DmhBHJDspfQIGQ9pArSi7bQ=;
        b=ewzwuNQJNv+rrAILk6q5QHFnd1Xzbim9h9jPAvXpQWCTVqKUJmJw++ZuvJ2MYk9fCx
         czzZhfUQJ6541scoc2zP5x8caPV4R3FzvKOXqehc3zRMpi+NGAJACZ9aWVponq/2HLdq
         roQhq+s37Hg01PjIBwDBF0Zc6qNUt1DhxJssk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMlK7Upw2ce5Zg7xMf34DmhBHJDspfQIGQ9pArSi7bQ=;
        b=j0zhkdzedSyMQenwE3zFk80zLcJ6ug95TBUlVCOFQ8DKkeotGOQl1q02xt9PFY8frG
         usGcLoYBHRJaBNAhothN5NWziFrk8foQhj32EMDkNfVxwuhF2X4p4m4JM3h+6ZMin0UR
         SJAiUSpCAHOP2YxTlpYyPBVR6uS9fvH4GTF7Pqy5zxfNKT1YeBdDPq0nUNepwuYElUXM
         NHDzxJF75HUHigsGDSb7bBARaqax8dkZa/1kce/YR+UvHigUFszt/aqfl1qYBC4ivQSw
         tZYTyEgjtbtPy2MB04SkE8kfHcS08gUBDq/A2cmk8XYLWNO6zW3nsRjeg5r0iAsPHS2t
         pP0g==
X-Gm-Message-State: APjAAAW4NytlFa/Sf2sCcmw67N4uXy7TV4KO7ZrEaM6UgPxgO4YAGvCT
        zbu7eouFtZbsCCCJwhWE+WtrZ/a1lMM=
X-Google-Smtp-Source: APXvYqz2Waas81vsj2RF/TnX2uxj15s7V4q2MPL1rFFfzRGveOkLO6XfRfcSESvY0nqMNsW5dDMmRw==
X-Received: by 2002:a05:651c:1ae:: with SMTP id c14mr7709772ljn.135.1573244798053;
        Fri, 08 Nov 2019 12:26:38 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id a5sm2764853ljm.56.2019.11.08.12.26.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 12:26:35 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id y23so7504432ljh.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 12:26:35 -0800 (PST)
X-Received: by 2002:a2e:9a8f:: with SMTP id p15mr7938802lji.148.1573244794852;
 Fri, 08 Nov 2019 12:26:34 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
 <CAHk-=wiZdSoweA-W_8iwLy6KLsd-DaZM0gN9_+f-aT4KL64U0g@mail.gmail.com>
 <CANpmjNOuRp0gdekQeodXm8O_yiXm7mA8WZsXZNmFfJYMs93x8w@mail.gmail.com>
 <CAHk-=wjodfXqd9=iW=ziFrfY7xqopgO3Ko_HrAUp-kUQHHyyqg@mail.gmail.com> <CANpmjNO6UgNS9h5ZwSV2c+uKz04ch96d+f0-jquDj_ekOjr5bQ@mail.gmail.com>
In-Reply-To: <CANpmjNO6UgNS9h5ZwSV2c+uKz04ch96d+f0-jquDj_ekOjr5bQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 12:26:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGfnHopopFDhcGp1=wg7XY8iGm7tDjgf_zfZZy5tdRjA@mail.gmail.com>
Message-ID: <CAHk-=wiGfnHopopFDhcGp1=wg7XY8iGm7tDjgf_zfZZy5tdRjA@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Marco Elver <elver@google.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 8, 2019 at 11:48 AM Marco Elver <elver@google.com> wrote:
>
> It's not explicitly aware of initialization or release. We rely on
> compiler instrumentation for all memory accesses; KCSAN then sets up
> "watchpoints" for sampled memory accesses, delaying execution, and
> checking if a concurrent access is observed.

Ok.

> This same approach could be used to ignore "idempotent writes" where
> we would otherwise report a data race; i.e. if there was a concurrent
> write, but the data value did not change, do not report the race. I'm
> happy to add this feature if this should always be ignored.

Hmm. I don't think it's valid in general, but it might be useful
enough in practice, at least as an option to lower the false
positives.

               Linus
