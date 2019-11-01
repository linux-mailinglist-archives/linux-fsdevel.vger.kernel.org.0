Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B31EC841
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 19:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKASH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 14:07:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33945 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfKASH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:07:28 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so11847034ion.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Nov 2019 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K71YtVHX64W3J+gcMlkPgOo/j5jpKpJ4xYX6R4xuIW8=;
        b=wibfpvX2XghCpSzEhr+T52O7XBVpiwm7HyI22ix/gTaiIC7gEcmZLuUbSx0QcsQk0l
         7VRG3ZZq0Zz2XfCiIZZuzCuYVVP74LAUeZhzMo1KcQxQFfRXGd1jELmu/076petYJJhw
         FGOUsARnK1A+7Ln8hL4GePo4EvzqNYH78HWQHlQ1cM4R6ezZZ/f9PGCAZlzQEQ/GXJrN
         /VS7ER187zHOZs8QEQX4iSRuc7/+eW/SLRjRy8mmks03POz92N+/6rG3pORbq2Fgn2lq
         C/ll3yctfnlA0gc4YVriCFxcbq9cUPpzRg3wjYzMuyrPzT0mOh4CC3kuW2+P1Tgj1vUy
         BVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K71YtVHX64W3J+gcMlkPgOo/j5jpKpJ4xYX6R4xuIW8=;
        b=YgW65Ag0zdLwCg40pUpA8pwlGv8Bk2QctOUfPthxbfeBnHjJnLqUOHStvAoHD8L3CR
         C3zp4kL8cjde3emvQu3C9zMjS8I1Kws6Iv2RwkmnNjMoSvog4ofpH3sWtH05msIBvHoM
         Z7mz97bpp93SBuzrnl2NquWr6AYOVWEz3kfn+YP5CXLvn6qHIZ4xyH//4II1qt2Pfyhm
         xrTCKCElG8qEuJ47Rv3leZVKjTrAAZ9Zjbcs2UDBpcXJee/CyAS/+YSe1l/SDtz1vUOL
         aUJKDUmHYohmuEWIwYaI9dIvvkB0325PKlOI5WhcNUn12zsHda4Ezh5n2CrjG8tSGojc
         DZQA==
X-Gm-Message-State: APjAAAUppNsgxXdxKmq64hcYo9W5bY7qXdyhZWWI2rbP0LWHmgiwgc1X
        bgNs+NV1jh3+0ms5qm11A1UpKaX4354yKRkd
X-Google-Smtp-Source: APXvYqzYvekLNlR2ZoxBIrbCFUUyKsQ/oi236DcQWJFt+PbJ/iT1RN0Ugdi1nEtUbU9QgAfXWDX4JQ==
X-Received: by 2002:a5e:c302:: with SMTP id a2mr11706975iok.295.1572631644822;
        Fri, 01 Nov 2019 11:07:24 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h16sm1201668ilq.18.2019.11.01.11.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 11:07:23 -0700 (PDT)
Subject: Re: BUG: unable to handle kernel paging request in io_wq_cancel_all
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, mchehab+samsung@kernel.org,
        Ingo Molnar <mingo@redhat.com>, patrick.bellasi@arm.com,
        Richard Guy Briggs <rgb@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <00000000000069801e05961be5fb@google.com>
 <0e2bc2bf-2a7a-73c5-03e2-9d08f89f0ffa@kernel.dk>
 <CACT4Y+asiAtMVmA2QiNzTJC8OsX2NDXB7Dmj+v-Uy0tG5jpeFw@mail.gmail.com>
 <7fe298b7-4bc9-58e7-4173-63e3cbcbef25@kernel.dk>
 <CACT4Y+au222UbfG_rbV+Zx6O75C1BHfCCw4R_Mp4ki4xw=_oDA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5e420723-8cc0-42ac-2ca4-d708af70fe3d@kernel.dk>
Date:   Fri, 1 Nov 2019 12:07:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+au222UbfG_rbV+Zx6O75C1BHfCCw4R_Mp4ki4xw=_oDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/1/19 12:03 PM, Dmitry Vyukov wrote:
> On Fri, Nov 1, 2019 at 6:56 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 11/1/19 11:50 AM, Dmitry Vyukov wrote:
>>> On Wed, Oct 30, 2019 at 3:41 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 10/30/19 1:44 AM, syzbot wrote:
>>>>> syzbot has bisected this bug to:
>>>>>
>>>>> commit ef0524d3654628ead811f328af0a4a2953a8310f
>>>>> Author: Jens Axboe <axboe@kernel.dk>
>>>>> Date:   Thu Oct 24 13:25:42 2019 +0000
>>>>>
>>>>>         io_uring: replace workqueue usage with io-wq
>>>>>
>>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16acf5d0e00000
>>>>> start commit:   c57cf383 Add linux-next specific files for 20191029
>>>>> git tree:       linux-next
>>>>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15acf5d0e00000
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=11acf5d0e00000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=cb86688f30db053d
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=221cc24572a2fed23b6b
>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168671d4e00000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140f4898e00000
>>>>>
>>>>> Reported-by: syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com
>>>>> Fixes: ef0524d36546 ("io_uring: replace workqueue usage with io-wq")
>>>>
>>>> Good catch, it's a case of NULL vs ERR_PTR() confusion. I'll fold in
>>>> the below fix.
>>>
>>> Hi Jens,
>>>
>>> Please either add the syzbot tag to commit, or close manually with
>>> "#syz fix" (though requires waiting until the fixed commit is in
>>> linux-next).
>>> See https://goo.gl/tpsmEJ#rebuilt-treesamended-patches for details.
>>> Otherwise, the bug will be considered open and will waste time of
>>> humans looking at open bugs and prevent syzbot from reporting new bugs
>>> in io_uring.
>>
>> It's queued up since two days ago:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring&id=975c99a570967dd48e917dd7853867fee3febabd
>>
>> and should have the right attributions, so hopefully it'll catch up
>> eventually.
>>
>> --
>> Jens Axboe
>>
> 
> Cool! Thanks!
> I've seen "fold in" and historically lots of developers did not add
> the tag during amending, so wanted to double check.

I'm often guilty of that, I think, but for this one I just kept it
separate since I didn't want to rebase things at this point. So I do
appreciate the reminder, I'm sure it'll be pertinent in many other
cases...

-- 
Jens Axboe

