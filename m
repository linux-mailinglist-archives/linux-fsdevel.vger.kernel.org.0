Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95BACCC6C3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2019 01:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfJDX5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 19:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfJDX5i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:57:38 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B5B4217F5;
        Fri,  4 Oct 2019 23:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570233456;
        bh=QnxgZGjRGb9kVa/AbzFU/w+ata+FCIrTiXgoxZKR668=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=14VBaXN2i1lZzsGbzc40dGmK4Kz7MeNzgfzYFP1mBUWKFrLWr5b8W2fbZxF7XWXT/
         kFJ2TnRAgZew/x23kGW5L/k2jFdvXDJGUxAALPAqq4xa3NgG7/4XUrOkkuVZWSwetb
         YcbcyPY+1xumtG3sOuB8AeQgccrkurfn3PNq0JFU=
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        shuah <shuah@kernel.org>
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20191004213812.GA24644@mit.edu>
 <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org>
 <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org>
 <20191004232955.GC12012@mit.edu>
 <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <63e59b0b-b51e-01f4-6359-a134a1f903fd@kernel.org>
Date:   Fri, 4 Oct 2019 17:57:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/19 5:52 PM, Brendan Higgins wrote:
> On Fri, Oct 4, 2019 at 4:30 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>
>> On Fri, Oct 04, 2019 at 04:47:09PM -0600, shuah wrote:
>>>> However, if I encourage arbitrary tests/improvements into my KUnit
>>>> branch, it further diverges away from torvalds/master, and is more
>>>> likely that there will be a merge conflict or issue that is not related
>>>> to the core KUnit changes that will cause the whole thing to be
>>>> rejected again in v5.5.
>>>
>>> The idea is that the new development will happen based on kunit in
>>> linux-kselftest next. It will work just fine. As we accepts patches,
>>> they will go on top of kunit that is in linux-next now.
>>
>> I don't see how this would work.  If I add unit tests to ext4, they
>> would be in fs/ext4.  And to the extent that I need to add test mocks
>> to allow the unit tests to work, they will involve changes to existing
>> files in fs/ext4.  I can't put them in the ext4.git tree without
>> pulling in the kunit changes into the ext4 git tree.  And if they ext4
>> unit tests land in the kunit tree, it would be a receipe for large
>> numbers of merge conflicts.
> 
> That's where I was originally coming from.
> 
> So here's a dumb idea: what if we merged KUnit through the ext4 tree?
> I imagine that could potentially get very confusing when we go back to
> sending changes in through the kselftest tree, but at least it means
> that ext4 can use it in the meantime, which means that it at least
> gets to be useful to one group of people. Also, since Ted seems pretty
> keen on using this, I imagine it is much more likely to produce real
> world, immediately useful tests not written by me (I'm not being lazy,
> I just think it is better to get other people's experiences other than
> my own).
> 

That doesn't make sense does it? The tests might not be limited to
fs/ext4. We might have other sub-systems that add tests.

So, we will have to work to make linux-next as the base for new
development and limit the number of tests to where it will be
easier work in this mode for 5.5. We can stage the pull requests
so that kunit lands first followed by tests.

We have a similar situation with kselftest as well. Sub-systems
send tests that depend on their tress separately.

thanks,
-- Shuah
