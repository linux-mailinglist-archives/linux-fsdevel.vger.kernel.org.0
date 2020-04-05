Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C75819EAA0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Apr 2020 13:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgDELHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Apr 2020 07:07:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35248 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgDELHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Apr 2020 07:07:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id i19so12696611wmb.0;
        Sun, 05 Apr 2020 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AlRG+LoppUJyQBaVTdt9cgVDBGOZQeT8M5I9dff2qrw=;
        b=nGU82UIH/LAsyRZZWFxKHVdA1ZPYtDp1N0LdWaHHzCfZSexdf8AcnzyK596fEUVH0y
         fKQDb9nvozu0Xtr1rBJpYPYWefzXvluth+LXYeRW4Dw2+0CLR2X0JNKALede267Q86Ac
         OEuQr494j/JKPDBp3+F1ENtRCM8YRAln9c2fE+ORVPz78xkZIQewHMFkB2sZggxgMoX+
         F9m57HEK2NDqcfzr2hKdr0qsHRFioj37SP+eSDMynLQgMKZVd5VL36bgymRXpTZKEPEE
         yN7dYOgJ1grB4UAsgbHUPrFcZf6WNIY8oOlv4ScMpm+pwJ8QTM+eG8zsg0OcD2N4ddL3
         oZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AlRG+LoppUJyQBaVTdt9cgVDBGOZQeT8M5I9dff2qrw=;
        b=oYcdyOXzSw/tuZ9eUH7E/FGRWHM11Y43mtTimnl6gB4c8zX7C5bthPUshER80Eq1gl
         7xCAUhBFrO9ewwWkvquAtaL0SAy2B7Pdmi1y6HKg/2w/AqR8euZLzN/tkSwNH235fBsm
         RTHqeIOYX/KOTF02EC6R+roRfLtquIZmtFjXdYVFX1vs+AzUpnlznyxY8KqcvnU+9C58
         8xHoWZyc39TkawUt/6+HIDVXnSZX0Mi6kkue2dox2CLRrdHvic2BqFcGvLJAv8QvwY+3
         WWVWHRRc7hjGT6UFGyZ5pDwsH49rSmE7zn1j3IxcEbGNWGIlrzYzTgaZhCBHK101wnGs
         qFjw==
X-Gm-Message-State: AGi0PuYVWBeNnt0i7QaSDhTKlZUba/8YTfFMLy+OM79RZPH06y1CjtK7
        7eQ++bz4ava5mVUoJB2UCkGeVQ8O
X-Google-Smtp-Source: APiQypKwVdPB3nw4bqwXFW8LTr9MyJV4J1LF0VaVSa7BbkonynyUE6TNDYQqFS/C/K8q1Fvgnidk5Q==
X-Received: by 2002:a05:600c:2251:: with SMTP id a17mr17446973wmm.106.1586084865623;
        Sun, 05 Apr 2020 04:07:45 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t2sm2415254wrs.7.2020.04.05.04.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Apr 2020 04:07:44 -0700 (PDT)
Date:   Sun, 5 Apr 2020 11:07:43 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200405110743.bzpvz4jzwr4kharr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-6-richard.weiyang@gmail.com>
 <20200330124842.GY22483@bombadil.infradead.org>
 <20200330141558.soeqhstone2liqud@master>
 <20200330142821.GD22483@bombadil.infradead.org>
 <20200331134208.gfkyym6n3gpgk3x3@master>
 <20200331164212.GC21484@bombadil.infradead.org>
 <20200331220440.roq4pv6wk7tq23gx@master>
 <20200331235912.GD21484@bombadil.infradead.org>
 <20200401221021.v6igvcpqyeuo2cws@master>
 <20200401222000.GK21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401222000.GK21484@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 01, 2020 at 03:20:00PM -0700, Matthew Wilcox wrote:
>On Wed, Apr 01, 2020 at 10:10:21PM +0000, Wei Yang wrote:
>> On Tue, Mar 31, 2020 at 04:59:12PM -0700, Matthew Wilcox wrote:
>> >On Tue, Mar 31, 2020 at 10:04:40PM +0000, Wei Yang wrote:
>> >> cc -I. -I../../include -g -Og -Wall -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o main.o main.c
>> >> In file included from ./linux/../../../../include/linux/radix-tree.h:15,
>> >>                  from ./linux/radix-tree.h:5,
>> >>                  from main.c:10:
>> >> ./linux/rcupdate.h:5:10: fatal error: urcu.h: No such file or directory
>> >>     5 | #include <urcu.h>
>> >>       |          ^~~~~~~~
>> >> compilation terminated.
>> >> make: *** [<builtin>: main.o] Error 1
>> >
>> >Oh, you need liburcu installed.  On Debian, that's liburcu-dev ... probably
>> >liburcu-devel on Red Hat style distros.
>> 
>> The bad news is I didn't find the package on Fedora.
>
>Really?  https://www.google.com/search?q=fedora+liburcu has the -devel
>package as the second hit from https://pkgs.org/search/?q=liburcu

Occasionally, I see this error message without my change on 5.6.


random seed 1586068185
running tests
XArray: 21151201 of 21151201 tests passed
=================================================================
==6040==ERROR: AddressSanitizer: heap-use-after-free on address 0x60c0031bce81 at pc 0x00000040b4b3 bp 0x7f95e87f9bb0 sp 0x7f95e87f9ba0
READ of size 1 at 0x60c0031bce81 thread T11
    #0 0x40b4b2 in xas_find_marked ../../../lib/xarray.c:1182
    #1 0x45318e in tagged_iteration_fn /root/git/linux/tools/testing/radix-tree/iteration_check.c:77
    #2 0x7f95ef2464e1 in start_thread (/lib64/libpthread.so.0+0x94e1)
    #3 0x7f95ee8026d2 in clone (/lib64/libc.so.6+0x1016d2)

0x60c0031bce81 is located 1 bytes inside of 128-byte region [0x60c0031bce80,0x60c0031bcf00)
freed by thread T1 here:
    #0 0x7f95ef36c91f in __interceptor_free (/lib64/libasan.so.5+0x10d91f)
    #1 0x43e4ba in kmem_cache_free /root/git/linux/tools/testing/radix-tree/linux.c:64

previously allocated by thread T13 here:
    #0 0x7f95ef36cd18 in __interceptor_malloc (/lib64/libasan.so.5+0x10dd18)
    #1 0x43e1af in kmem_cache_alloc /root/git/linux/tools/testing/radix-tree/linux.c:44

Thread T11 created by T0 here:
    #0 0x7f95ef299955 in pthread_create (/lib64/libasan.so.5+0x3a955)
    #1 0x454862 in iteration_test /root/git/linux/tools/testing/radix-tree/iteration_check.c:178

Thread T1 created by T0 here:
    #0 0x7f95ef299955 in pthread_create (/lib64/libasan.so.5+0x3a955)
    #1 0x7f95ef235b89  (/lib64/liburcu.so.6+0x3b89)

Thread T13 created by T0 here:
    #0 0x7f95ef299955 in pthread_create (/lib64/libasan.so.5+0x3a955)
    #1 0x4548a4 in iteration_test /root/git/linux/tools/testing/radix-tree/iteration_check.c:186

SUMMARY: AddressSanitizer: heap-use-after-free ../../../lib/xarray.c:1182 in xas_find_marked
Shadow bytes around the buggy address:
  0x0c188062f980: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
  0x0c188062f990: 00 00 00 00 00 00 00 00 fa fa fa fa fa fa fa fa
  0x0c188062f9a0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c188062f9b0: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c188062f9c0: fd fd fd fd fd fd fd fd fa fa fa fa fa fa fa fa
=>0x0c188062f9d0:[fd]fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c188062f9e0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c188062f9f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c188062fa00: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c188062fa10: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c188062fa20: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
==6040==ABORTING

This is not always like this. Didn't figure out the reason yet. Hope you many
have some point.

-- 
Wei Yang
Help you, Help me
