Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2320F5349
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 19:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKHSMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 13:12:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35508 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfKHSMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:12:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id r7so7202686ljg.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UwOe/0M2mqJUTnI7Cbij9+EXC9Tu0LMdXKdxLl7NQv8=;
        b=Tty72ZI+f/UrYcmEO8Ttap8J2ndzFJNgOvOIEsjOGXNDZDxbS3eJdFc1wvOgAkhTae
         HLu2Gs/SEuoh93AyFYWuYVGXZRyvcZzwo9IRcP7UYgKpfdaT0318sOFFV7yfTAuoQUuM
         qzCAoo7N2AMj7L2Iz8ESsZqrPCxDcoIImZAlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UwOe/0M2mqJUTnI7Cbij9+EXC9Tu0LMdXKdxLl7NQv8=;
        b=Zi7LexkBf/xBD9oVWVpCcUth7t5Y869i5v/2Js2JEVVdqS4cgx3KLX0WV4XyvVpUt9
         kYlP+briDXKA/EZNLPcSRTdPkQEug4rr8s3URTZaI183eGsj8KhnRLLqZXM37eRzUoU1
         1+ktT3RDxr1n+pwnlP7hECmF/SvXC3vs/2BjWriXnFDvaESxstno+QGskoyfjwYQUbTL
         qLHnE7xletVto/Oj3MmRCIQ+DQsVWuwJRbFcrIOfvhTk6y7GjQMv33NNqqDVUx4CrmD3
         IOaoYPplPPQmLS2ZjSmjwmMFTFJ3OALYiZHd2gwlZAm73PU6t/JXsD3UEZawScPlf7iT
         T+ig==
X-Gm-Message-State: APjAAAXiVSSxwGx28TI0N6DbMPOIET3ZCBDpP6JIA9AIn0ZBNNMiSEpG
        lpI+4Ro24MEB9FXJSDfbR7z0acBdeI0=
X-Google-Smtp-Source: APXvYqyiEkLQZB8NPmzNvgCNsXJLIuEf+XJ35vlCWiXHTKrgAQqJFoQojAZG1u/68WbkXEpco0fsfw==
X-Received: by 2002:a2e:9208:: with SMTP id k8mr7955365ljg.14.1573236754140;
        Fri, 08 Nov 2019 10:12:34 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id u2sm3168833lfc.23.2019.11.08.10.12.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 10:12:33 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 139so7190224ljf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 10:12:31 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr7846398ljp.133.1573236751292;
 Fri, 08 Nov 2019 10:12:31 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
 <CANn89i+RrngUr11_iOYDuqDvAZnPfG3ieJR025M78uhiwEPuvQ@mail.gmail.com> <CANn89iLN758CpQPKcd++NLdj62LS-ekiEUV91VREzMsamLn9bw@mail.gmail.com>
In-Reply-To: <CANn89iLN758CpQPKcd++NLdj62LS-ekiEUV91VREzMsamLn9bw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 10:12:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5+N2WS2vO6doxfza1G8zk4DP5RhodiaSeAyf+Ooy7wQ@mail.gmail.com>
Message-ID: <CAHk-=wg5+N2WS2vO6doxfza1G8zk4DP5RhodiaSeAyf+Ooy7wQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 8, 2019 at 10:02 AM Eric Dumazet <edumazet@google.com> wrote:
>
> Another interesting KCSAN report :
>
> static inline s64 percpu_counter_read_positive(struct percpu_counter *fbc)
> {
>         s64 ret = fbc->count;   // data-race ....

Yeah, I think that's fundamentally broken on 32-bit. It might need a
sequence lock instead of that raw_spinlock_t to be sanely done
properly on 32-bit.

Or we just admit that 32-bit doesn't really matter any more in the
long run, and that this is not a problem in practice because the
32-bit overflow basically never happens on small machines anyway.

               Linus
