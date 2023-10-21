Return-Path: <linux-fsdevel+bounces-865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61A7D1A5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 03:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493BF2827B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 01:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05992802;
	Sat, 21 Oct 2023 01:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD97EA
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 01:48:44 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8897DD6C;
	Fri, 20 Oct 2023 18:48:42 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SC46T4YR8z15NKl;
	Sat, 21 Oct 2023 09:45:53 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 21 Oct 2023 09:48:39 +0800
Message-ID: <826dbab6-f6e0-fc02-e5d3-141c00a2a141@huawei.com>
Date: Sat, 21 Oct 2023 09:48:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Linus Torvalds
	<torvalds@linux-foundation.org>
CC: Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>, Ferry Toth <ftoth@exalondelft.nl>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>, yangerkun
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com>
 <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com> <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com> <ZTKXbbSS2Pvmc-Fh@smile.fi.intel.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <ZTKXbbSS2Pvmc-Fh@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

On 2023/10/20 23:06, Andy Shevchenko wrote:
> +Cc: Baokun, the author of the patch.
>
> On Fri, Oct 20, 2023 at 05:51:59PM +0300, Andy Shevchenko wrote:
>> On Thu, Oct 19, 2023 at 11:43:47AM -0700, Linus Torvalds wrote:
>>> On Thu, 19 Oct 2023 at 11:16, Andy Shevchenko
>>> <andriy.shevchenko@intel.com> wrote:
>>>> Meanwhile a wild idea, can it be some git (automatic) conflict resolution that
>>>> makes that merge affect another (not related to the main contents of the merge)
>>>> files? Like upstream has one base, the merge has another which is older/newer
>>>> in the history?
>>> I already looked at any obvious case of that.
>>>
>>> The only quota-related issue on the other side is an obvious
>>> one-liner: commit 86be6b8bd834 ("quota: Check presence of quota
>>> operation structures instead of ->quota_read and ->quota_write
>>> callbacks").
>>>
>>> It didn't affect the merge, because it was not related to  any of the
>>> changes that came in from the quota branch (it was physically close to
>>> the change that used lockdep_assert_held_write() instead of a
>>> WARN_ON_ONCE(down_read_trylock()) sequence, but it is unrelated to
>>> it).
>>>
>>> I guess you could try reverting that one-liner after the merge, but I
>>> _really_ don't think it is at all relevant.
>>>
>>> What *would* probably be interesting is to start at the pre-merge
>>> state, and rebase the code that got merged in. And then bisect *that*
>>> series.
>>>
>>> IOW, with the merge that triggers your bisection being commit
>>> 1500e7e0726e, do perhaps something like this:
>>>
>>>    # Name the states before the merge
>>>    git branch pre-merge 1500e7e0726e^
>>>    git branch jan-state 1500e7e0726e^2
>>>
>>>    # Now double-check that this works for you, of course.
>>>    # Just to be safe...
>>>    git checkout pre-merge
>>>    .. test-build and test-boot this with the bad config ..
>> That's I have checked already [4], but okay, let me double check.
>> [5] is the same as [4] according to `git diff`.
>>
>> It boots.
>>
>>>    # Then, let's create a new branch that is
>>>    # the rebased version of Jan's state:
>>>    git checkout -b jan-rebased jan-state
>>>    git rebase pre-merge
>> [6] is created.
>>
>>>    # Verify that the tree is the same as the merge
>>>    git diff 1500e7e0726e
>> Yes, nothing in output.
>>
>> And it does not boot.
>>
>>>    # Ok, that was empty, so do a bisect on this
>>>    # rebased history
>>>    git bisect start
>>>    git bisect bad
>>>    git bisect good pre-merge
>>>
>>> .. and see what commit it *now* claims is the bad commit.
>> git bisect start
>> # status: waiting for both good and bad commits
>> # good: [63580f669d7ff5aa5a1fa2e3994114770a491722] Merge tag 'ovl-update-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs
>> git bisect good 63580f669d7ff5aa5a1fa2e3994114770a491722
>> # status: waiting for bad commit, 1 good commit known
>> # bad: [2447ff4196091e41d385635f9b6d003119f24199] ext2: Fix kernel-doc warnings
>> git bisect bad 2447ff4196091e41d385635f9b6d003119f24199
>> # bad: [a7c4109a1fa7f9f8cfa9aa93e7aae52d0df820f6] MAINTAINERS: change reiserfs status to obsolete
>> git bisect bad a7c4109a1fa7f9f8cfa9aa93e7aae52d0df820f6
>> # bad: [74fdc82e4a4302bf8a519101a40691b78d9beb6c] quota: add new helper dquot_active()
>> git bisect bad 74fdc82e4a4302bf8a519101a40691b78d9beb6c
>> # bad: [e64db1c50eb5d3be2187b56d32ec39e56b739845] quota: factor out dquot_write_dquot()
>> git bisect bad e64db1c50eb5d3be2187b56d32ec39e56b739845
>> # good: [eea7e964642984753768ddbb710e2eefd32c7a89] ext2: remove redundant assignment to variable desc and variable best_desc
>> git bisect good eea7e964642984753768ddbb710e2eefd32c7a89
>> # first bad commit: [e64db1c50eb5d3be2187b56d32ec39e56b739845] quota: factor out dquot_write_dquot()
>>
>>> Would you be willing to do this? It should be only a few bisects,
>>> since Jan's branch only brought in 17 commits that the above rebases
>>> into this test branch. So four or five bisections should pinpoint the
>>> exact point where it goes bad.
>> See above.
>>
>> I even rebuilt again with just rebased on top of e64db1c50eb5 and it doesn't
>> boot, so we found the culprit that triggers this issue.
>>
Hello, Addy!

This patch does not seem to cause this problem. Just like linus said, 
this patch
has only two slight differences from the previous:
1) Change "if (err)" to "if (err < 0)"
     In all the implementations of dq_op->write_dquot(), the returned 
value of err
     is not greater than 0. Therefore, this does not cause behavior 
inconsistency.
2) Adding quota_error()
     quota_error() does not seem to cause a boot failure.

Also, you mentioned that the root file system is initramfs. If no other 
file system
that supports quota is automatically mounted during startup, it seems 
that quota
does not cause this problem logically.

In my opinion, as Josh mentioned, replace the CONFIG_DEBUG_LIST related
BUG()/BUG_ON() with WARN_ON(), and then check whether the system can be
started normally. If yes, it indicates that the panic is caused by the 
list corruption,
then, check for the items that may damage the list. If WARN_ON() is 
recorded in
the dmesg log of the machine after the startup, it is easier to locate 
the problem.

-- 
With Best Regards,
Baokun Li
.

