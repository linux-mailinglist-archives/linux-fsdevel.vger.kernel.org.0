Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680F8CE633
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 16:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfJGO5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 10:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGO5l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:57:41 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E805206C2;
        Mon,  7 Oct 2019 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570460259;
        bh=M/mh7ZDKuNzaoClSYB7rLWBjChHoOPyPKzoupCtmj/s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OknCZl7G7XB2x/+wPMOTWsiPriTJeKEbR+zS47+ClfRbCU63jUlK1d+xBxWuJuzCB
         c521NSoNfrmZ7l21+c+4hgme2giarn46R0KzyXhix6klLtQym1/TJUpxv1eArw06l2
         ryeCnoXId3pvz7NjvXBDnl/VEqPPEm1JHVs1Iizw=
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Brendan Higgins <brendanhiggins@google.com>,
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
        David Rientjes <rientjes@google.com>, wfg@linux.intel.com,
        shuah <shuah@kernel.org>
References: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org>
 <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org>
 <20191004232955.GC12012@mit.edu>
 <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
 <63e59b0b-b51e-01f4-6359-a134a1f903fd@kernel.org>
 <CAFd5g47wji3T9RFmqBwt+jPY0tb83y46oj_ttOq=rTX_N1Ggyg@mail.gmail.com>
 <544bdfcb-fb35-5008-ec94-8d404a08fd14@kernel.org>
 <CAFd5g467PkfELixpU0JbaepEAAD_ugAA340-uORngC-eXsQQ-g@mail.gmail.com>
 <20191006165436.GA29585@mit.edu>
 <CAHk-=wjcJxypxUOSF-jc=SQKT1CrOoTMyT7soYzbvK3965JmCA@mail.gmail.com>
 <20191007104048.66ae7e59@gandalf.local.home>
From:   shuah <shuah@kernel.org>
Message-ID: <176fa69d-1767-ea9b-476d-c685c2a68d46@kernel.org>
Date:   Mon, 7 Oct 2019 08:57:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007104048.66ae7e59@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/7/19 8:40 AM, Steven Rostedt wrote:
> On Sun, 6 Oct 2019 10:18:11 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Sun, Oct 6, 2019 at 9:55 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>>
>>> Well, one thing we *can* do is if (a) if we can create a kselftest
>>> branch which we know is stable and won't change, and (b) we can get
>>> assurances that Linus *will* accept that branch during the next merge
>>> window, those subsystems which want to use kself test can simply pull
>>> it into their tree.
>>
>> Yes.
>>
>> At the same time, I don't think it needs to be even that fancy. Even
>> if it's not a stable branch that gets shared between different
>> developers, it would be good to just have people do a "let's try this"
>> throw-away branch to use the kunit functionality and verify that
>> "yeah, this is fairly convenient for ext4".
>>
>> It doesn't have to be merged in that form, but just confirmation that
>> the infrastructure is helpful before it gets merged would be good.
> 
> Can't you just create an ext4 branch that has the kselftest-next branch
> in it, that you build upon. And push that after the kunit test is
> merged?
> 
> In the past I've had to rely on other branches in next, and would just
> hold two branches myself. One with everything not dependent on the other
> developer's branch, and one with the work that was. At the merge
> window, I would either merge the two or just send two pull requests
> with the two branches.
> 

I do something similar when I am working on top of a branch that isn't
already in the mainline. In any case, repeating myself

Let's work on top of - it is rebased to 5.4-rc1 and ready for use.

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test

Let's use that for kunit work for 5.5. I won't add any kselftest patches
to it and keep it dedicated for kunit work. When tests are ready for
upstream, I can keep adding them to this branch.

thanks,
-- Shuah
