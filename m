Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 208F719E127
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Apr 2020 00:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgDCWjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 18:39:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35372 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCWjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 18:39:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so8094870wrx.2;
        Fri, 03 Apr 2020 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UpKvuDI1PGicwT1rg/Ja3rf4nyRsLxbYz+4E9C/TDSU=;
        b=BQO68LKDoogOR16LZjyPauaQEdOkEIbHpIEoXwMzrJie0LrjWI6YUmv50fv3D07VY6
         KgboFHwMT+JPhcOlK5Rdbrc8g7C402ueF43OgP2NyCfMas/DBHjwXkLjsajPppWIjGVK
         tEnTOCA8HJwn3GyANS/ikGDV5xOn0rq/FOu8nnKjHUAzl/7sQJ6zAVSbIi6Du/g0E/0d
         3NFk7hHYR6Eobj2jyTRRXqPPJw6is9NDKyIPw5w8dgEFfjEeTx1jv1aDjc6c4uBCPh7j
         YtbjDYsP+hWxr0tLCS0UgSdROh1bDHi8yOdIJC5kOgdTzieHF38S8bVcvuN5CjrgkAmF
         NcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UpKvuDI1PGicwT1rg/Ja3rf4nyRsLxbYz+4E9C/TDSU=;
        b=JpuSAmUQNqwQxQEVT41e1eX8LjRzCS4ZoXoM+LUar2bVFF8Ishq5K2f+ZXlxRck7sg
         /FTgvb7nmsjl7GUtvquZRjR/dGO/r1fELx7euvHbNmY+4hUuCJ+89p/XfRLVQAHI4Egr
         +6lqa7GhKC0XqIX1TFecrop9ukjRhAtdQdLqAxSSQtesyfzfEd23EKof9A0ceOm8r4Lz
         K11rJccCZ42v2ZzjqZF9MKOU7XaQXqcDMZXJOtAGk3s/dQ4PXYy0Y9DYJ+2CMWWtGq5p
         ZwFHa5NRGXEDSRM5HxPA3JkcPQIrnpjH0dzSkzvGgGH4qerImFMMxINx5+mgNUOF5vVh
         ACqw==
X-Gm-Message-State: AGi0PuZcc705sXmxQvkqIEI31p7B0VoPeDCO9Mo5xhpJnxb1q5VLEjqy
        L6hS1gPdTN95FLGE9ylXW0w=
X-Google-Smtp-Source: APiQypIIjX4dVjK/pfyxINrITNHRDZUv1crUf2VsOxM8ntQcX/E1QQHm/gbT6AspeE9o6pgdcMHkiw==
X-Received: by 2002:a5d:44c4:: with SMTP id z4mr1675877wrr.221.1585953575218;
        Fri, 03 Apr 2020 15:39:35 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 189sm13554498wme.31.2020.04.03.15.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 15:39:34 -0700 (PDT)
Date:   Fri, 3 Apr 2020 22:39:33 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200403223933.vkwfwatu572entz4@master>
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

Did a run on 5.6 without my change. The output is

[root@debug010000002015 radix-tree]# ./main
random seed 1585904186
running tests
XArray: 21151201 of 21151201 tests passed
vvv Ignore these warnings
assertion failed at idr.c:269
assertion failed at idr.c:206
^^^ Warnings over
IDA: 34980531 of 34980531 tests passed
tests completed

Is these two assertion expected?

-- 
Wei Yang
Help you, Help me
