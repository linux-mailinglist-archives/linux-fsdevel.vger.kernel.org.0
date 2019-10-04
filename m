Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C868CC611
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2019 00:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfJDWrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 18:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJDWrO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:47:14 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27C0D20873;
        Fri,  4 Oct 2019 22:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570229232;
        bh=xzHJwRDpMutixnFislQvEBP/YT7jem/U/8kCBigrHuc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iwzzgBVqn0QkoDuULW/O4NrloecUNaYOg0c99vmkwrF/zjed3x2bOMaHRqdx3FMcB
         x9c+A3rz+204+uJreaQuOoW8uMDh6bYqcKQgfB1jhKbgSV/JJFS70YgyJLCTDDtbp8
         DUCzwKxib6rwVWWLjRz787WWmuX5+RAponaYusdk=
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        kieran.bingham@ideasonboard.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, robh@kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
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
        Sasha Levin <Alexander.Levin@microsoft.com>, Tim.Bird@sony.com,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, jdike@addtoit.com,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com,
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
From:   shuah <shuah@kernel.org>
Message-ID: <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org>
Date:   Fri, 4 Oct 2019 16:47:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004222714.GA107737@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/19 4:27 PM, Brendan Higgins wrote:
> On Fri, Oct 04, 2019 at 03:59:10PM -0600, shuah wrote:
>> On 10/4/19 3:42 PM, Linus Torvalds wrote:
>>> On Fri, Oct 4, 2019 at 2:39 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>>>
>>>> This question is primarily directed at Shuah and Linus....
>>>>
>>>> What's the current status of the kunit series now that Brendan has
>>>> moved it out of the top-level kunit directory as Linus has requested?
>>>
>>
>> The move happened smack in the middle of merge window and landed in
>> linux-next towards the end of the merge window.
>>
>>> We seemed to decide to just wait for 5.5, but there is nothing that
>>> looks to block that. And I encouraged Shuah to find more kunit cases
>>> for when it _does_ get merged.
>>>
>>
>> Right. I communicated that to Brendan that we could work on adding more
>> kunit based tests which would help get more mileage on the kunit.
>>
>>> So if the kunit branch is stable, and people want to start using it
>>> for their unit tests, then I think that would be a good idea, and then
>>> during the 5.5 merge window we'll not just get the infrastructure,
>>> we'll get a few more users too and not just examples.
> 
> I was planning on holding off on accepting more tests/changes until
> KUnit is in torvalds/master. As much as I would like to go around
> promoting it, I don't really want to promote too much complexity in a
> non-upstream branch before getting it upstream because I don't want to
> risk adding something that might cause it to get rejected again.
> 
> To be clear, I can understand from your perspective why getting more
> tests/usage before accepting it is a good thing. The more people that
> play around with it, the more likely that someone will find an issue
> with it, and more likely that what is accepted into torvalds/master is
> of high quality.
> 
> However, if I encourage arbitrary tests/improvements into my KUnit
> branch, it further diverges away from torvalds/master, and is more
> likely that there will be a merge conflict or issue that is not related
> to the core KUnit changes that will cause the whole thing to be
> rejected again in v5.5.
> 

The idea is that the new development will happen based on kunit in
linux-kselftest next. It will work just fine. As we accepts patches,
they will go on top of kunit that is in linux-next now.

thanks,
-- Shuah
