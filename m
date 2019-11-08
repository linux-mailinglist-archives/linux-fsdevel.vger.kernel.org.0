Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79432F5A2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 22:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbfKHVgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 16:36:45 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:45846 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730989AbfKHVgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:36:45 -0500
Received: by mail-lj1-f178.google.com with SMTP id n21so7676427ljg.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 13:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGYbfXBmYeGO7pa06B9v9RYZuC6G4mksi25tARbE4oY=;
        b=D2lIv3jCmGx6XX86kRru64oEZZHnbWw2knlo1We7LolVbJbNK9HgSHPqCuNFkLo8ad
         GU8k1DTmDoi/kms3XxcfX7lhY59TGnHP8CiCPpdo/DYtNT8a4RPLc9sR5QaxINzKAI91
         MruliR/YTKfAHzSlhF17f4O8c+PUKsS3yl0wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGYbfXBmYeGO7pa06B9v9RYZuC6G4mksi25tARbE4oY=;
        b=mgAk1SvyD5oENW9XxRMeMYdlHcMCUYMNYejvYdi4WZQ8VHOpJLkCfU2psmFRJAmrZG
         4kaj/eDmRz/O3SCU9rcVrgzly6HXOugdWYnIvCg46HlvUWJCJBTfouMn2Vd0jemzUKjL
         Lr98YPcF4tqbckhkh3fob89v4gpm8uThO4bu4059H0JR6LY2gUUtO1/TqgtKijF8NV6D
         5/Tcsvbygk8DtFNqI6NkFkBWonZR6PtoQZBdgWg1J+/IuHxHDB0SuBGE4CkbZ9uGDHaD
         nPlsRzUv5Luc7iH8WUejQsM5ytEe9w3FnO4VXDld3MzwR8gSr++dMCIleSqnIiAOU3H7
         8c1Q==
X-Gm-Message-State: APjAAAXw8hULvSrNdZSNNNxBJquupHXrag3DGa+4R1Ly0NEh5oDfuF9W
        /rTqQbPMVoY7GGjlbTtIS6d78KNipms=
X-Google-Smtp-Source: APXvYqxSc/cT54cDcmf/IxrYlT2MVG1eDPBlHjk7jvk/UeH0ApO6KpKnHarAMufEs0+7eHLWzpEgIw==
X-Received: by 2002:a05:651c:313:: with SMTP id a19mr769805ljp.199.1573249002483;
        Fri, 08 Nov 2019 13:36:42 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c22sm3632640lfj.28.2019.11.08.13.36.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 13:36:41 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id l21so371314ljg.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 13:36:40 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr8336920ljp.133.1573249000556;
 Fri, 08 Nov 2019 13:36:40 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
 <CANn89i+RrngUr11_iOYDuqDvAZnPfG3ieJR025M78uhiwEPuvQ@mail.gmail.com>
 <CAHk-=wi-aTQx5-gD51QC6UWJYxQv1p1CnrPpfbn4X1S4AC7G-g@mail.gmail.com> <CANn89iJh-WcvZYQEfdK=RGswQX8e1rp=CR27a6kWQkgK996P7g@mail.gmail.com>
In-Reply-To: <CANn89iJh-WcvZYQEfdK=RGswQX8e1rp=CR27a6kWQkgK996P7g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 13:36:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh_-1pj0vsAHiHf_FVardKkN7AZGX73QwGpViMyF7_mvQ@mail.gmail.com>
Message-ID: <CAHk-=wh_-1pj0vsAHiHf_FVardKkN7AZGX73QwGpViMyF7_mvQ@mail.gmail.com>
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

On Fri, Nov 8, 2019 at 12:53 PM Eric Dumazet <edumazet@google.com> wrote:
>
> per cpu SNMP counters mostly, with no IRQ safety requirements.
>
> Note that this could be implemented using local{64}_add() on arches like x86_64,
> while others might have to fallback to WRITE_ONCE(variable, variable + add)

raw_cpu_add()?

We already use those for vm_counters where we intentionally accept races.

              Linus
