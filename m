Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3507A416440
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 19:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242206AbhIWRVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 13:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbhIWRVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:21:34 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934C6C061574;
        Thu, 23 Sep 2021 10:20:02 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x9so6969621qtv.0;
        Thu, 23 Sep 2021 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=i/FJO8tUDM+bCLrLuDiTK4JNa8RKTqG1P9QwB4CtvdA=;
        b=dfKjYMKOJsbt58dIzAohG+sX87IerrWtNuCK6+ugwnPYaW3aHnS5AaqPGXiCRM1cCl
         jeo8pSxroC9vh4s5owFyAI432kcqbjB8Zvz1ZQceEf86HZelXxU+bqcBYiL0xFCWBJY4
         T8KGR5M+rW2II6OSgz1WE5U/8hsMjIiBC4o4AFpKKjM4/TihmPyag8oZ0PUo1PqtzA4a
         ISoTwSGXVc5LBNWizAsOF0mjuwTkaJeo2ZcFel4q+hKXkbZmf4Aq/sdBgTRZ8YsppGM6
         BBlL7o+Qu335cIKmY5gVD7GnfS3cT04rCAJu2Q16KDA/Ef/WXVr4yxioX2q2/qOYV1Sr
         o0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i/FJO8tUDM+bCLrLuDiTK4JNa8RKTqG1P9QwB4CtvdA=;
        b=ra0mt/MhPgeHkT2OsP/YuB6i9OFpMY+HSwlMRvw/eTuB7GvggZhBytxtaHbsXm3V7i
         HH3LKb4y8Kcrlxl7xYGGPVmPExjTD2YLuNB+UNUSVreMBVPba8oKkYMZGuOFEs266slB
         3vExELNtlpYj0BH2Odg0Uv26CY0ebCvKnnG3eGWx6I8GjHBfHy6Rx4mWLAajAgSMD+TG
         4Ciq+lg6XiUMWM9vF7LVyvKgKA2ktLSrK+K2X1nwMr3eCFK2FMtE7T6nMZYyKBjhLxOk
         FN6F8ldtdlXDU60EUl9N6IYpDC8F8EUhm/MurynHvLOcYg6OJk4rI/FhHFLCQHv695hD
         8sCg==
X-Gm-Message-State: AOAM530ZHS2vfUzc3hG7clz/UhYhMATKR6VD9geiHABmRY75Rs9KyClH
        el3qYPnbTfO0YDTChetKEz0=
X-Google-Smtp-Source: ABdhPJw4mVXU2bbawRdtEGuee0DWU8pg3BEgYy+b6z7UmtdWviI1vIOsHBJBzH31JqZlW1OyF2AT3w==
X-Received: by 2002:ac8:5c4c:: with SMTP id j12mr6068396qtj.127.1632417601737;
        Thu, 23 Sep 2021 10:20:01 -0700 (PDT)
Received: from ?IPv6:2620:6e:6000:3100:99db:7190:fb26:bcb0? ([2620:6e:6000:3100:99db:7190:fb26:bcb0])
        by smtp.gmail.com with ESMTPSA id 188sm4574046qkm.21.2021.09.23.10.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 10:20:01 -0700 (PDT)
Subject: Re: [syzbot] possible deadlock in f_getown
To:     syzbot <syzbot+8073030e235a5a84dd31@syzkaller.appspotmail.com>,
        asm@florahospitality.com, bfields@fieldses.org,
        boqun.feng@gmail.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
References: <000000000000ed2e6705cca36282@google.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <ff026440-590e-6268-6ced-326f4da27be2@gmail.com>
Date:   Thu, 23 Sep 2021 13:20:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <000000000000ed2e6705cca36282@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/9/21 2:03 am, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit f671a691e299f58835d4660d642582bf0e8f6fda
> Author: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> Date:   Fri Jul 2 09:18:30 2021 +0000
> 
>      fcntl: fix potential deadlocks for &fown_struct.lock
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fa8017300000
> start commit:   293837b9ac8d Revert "i915: fix remap_io_sg to verify the p..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=18fade5827eb74f7
> dashboard link: https://syzkaller.appspot.com/bug?extid=8073030e235a5a84dd31
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171390add00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10050553d00000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: fcntl: fix potential deadlocks for &fown_struct.lock
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

#syz fix: fcntl: fix potential deadlocks for &fown_struct.lock

Think I got jumbled a bit when marking the dups. This bug shares the 
same root cause as [1], and is fixed by the same patch. Nice that Syzbot 
noticed.

Link: https://syzkaller.appspot.com/bug?extid=e6d5398a02c516ce5e70 [1]
