Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55BD320194
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 00:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBSXMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 18:12:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:39871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhBSXMF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613776219;
        bh=pk2J+dNvcnUxciNZDUeB9awZvU4JA2hZepjFH1/b94c=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Ge12YJhJKhGx74fGGWzS4ll+Sjp5xxoiS2cZ3cCl5P7EoSJz3vOWiY9tkHuIG7tu1
         MsDT6qNK+7Bur/zxS8SH9cgTisOlsqcSuaq8jj6lfn0IGueiWav4hkNpMiHqi3PW/A
         gqYF+R8K4vzoq8rUvGnzDueA+Ql6rnptqGSzLQ+k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M72sP-1lCzG12v9T-008cnq; Sat, 20
 Feb 2021 00:10:19 +0100
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com>
 <20210218133954.GR2858050@casper.infradead.org>
 <e0faf229-ce7f-70b8-8998-ed7870c702a5@gmx.com> <YC/jYW/K9krbfnfl@mit.edu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <df225e6c-b70d-fb2d-347c-55efa910cfdd@gmx.com>
Date:   Sat, 20 Feb 2021 07:10:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC/jYW/K9krbfnfl@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R26fOfOHp/D217mYj27y7ult3hXKK75wfsJRoHsCdP9gpAPCTTT
 vFLvSPn2uzSE6uV+r6l7qE6L64k6tGSUzbvBn0wKd/CiNQ1LVY9/yD4256o2ydr2blXLubq
 jKMT7iNT6bjY6MLZYnttBHLYQgQdgLBr+O4imzttqhaWAUNKbfTNBdcdGMV23VaE6vVr3iF
 kx/5WIyEuJGnHa2g7DGGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CcTep701kYA=:JBwny/gXGHBPP70DC5fTzi
 3l029/OOq1fLNj//ySCLP/QgVQ9mdklCpjkw1Phcm51S/vMcIFsY1MQXjD6hXAQ1BPCSsvx7z
 y7OQiNs1V9AXMRRy+xBVI7Izazrqlc8ISU4HgunYQzfT/lLzNYjSy7sKLMZtH+dZo9IdIlGqJ
 UsGLYNurFZzcXX2CnLJp5SfZd6wUNQhwP05LWfu/NqvlO0H9NmCwsWE1izzJXXKlDbP+ySfGk
 Eni1aR/0PMInbtNUc+HBj6NY1o0uVOtdHTBPL9umZNnI86HTnWtuE8yNxAoflqB76sX+4h9O2
 LM1l/J9y8DuPnXC9MFG3V8s77XqDbDJN7w2aIZVoPiYMmm236/4wNBuW5ImCy/DoMe46bordN
 J8S6kPiYhM+NUahdaZkevfSakSb4QBraZE/D7aAEDBb9fcNAbMpcryvych0b5piHZBkP32fZ0
 TXllXDpdFBl1rM0LERgn3anYayvtbMHcUGS9DlZx32aTaadRWfMCVZMiJKjHmml6uQDwIPld2
 NN87aQuhFfTeiwzrv/lAIGIzKH6YV9mWsT786a56Pfdj/7erJRIntHBgYpUQixZadGNbHlWv2
 ye5PwALrAX3/v2pACighHoKsdXdBxbvhJNI2cdg9eXS8DO6wfOXOAHwNgYbla7gO0MXghEADi
 IRsKe5S/96prxGE9rpbgeAcXoixqngZob7uHo09vmfNz/I216KBt8VBvF8AbNPZ5VyeeT9d5a
 CHuLyVYdxeOqrOSaJDZneDG1SRviyJ6+wLg8sRJsPkfi1+XKmhavfJRUBhmc0hlqjwo6wsbIb
 PXjTlA0gx0vYHZqXO7D6pw3ilXXGt7nmXjrUmP7UlS3oraQe0mkGbOUnAwIEUKJvRGbJI+Orp
 p+L05lic/W+/3XL605lA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/20 =E4=B8=8A=E5=8D=8812:12, Theodore Ts'o wrote:
> On Fri, Feb 19, 2021 at 08:37:30AM +0800, Qu Wenruo wrote:
>> So it means the 32bit archs are already 2nd tier targets for at least
>> upstream linux kernel?
>
> At least as far as btrfs is concerned, anyway....

I'm afraid that would be the case.

But I'm still interested in how other fses handle such problem.

Doesn't they rely on page::index to handle their metadata?
Or all other fses just don't support allocating/deleting their AG/BG
dynamically so they can reject the fs at mount time?

Or they limit their metadata page::index to just inside each AG/BG?

Anyway, I'm afraid we have to reject the fs at both mount time and
runtime for now.

>
>> Or would it be possible to make it an option to make the index u64?
>> So guys who really wants large file support can enable it while most
>> other 32bit guys can just keep the existing behavior?
>
> I think if this is going to be done at all, it would need to be a
> compile-time CONFIG option to make the index be 64-bits.  That's
> because there are a huge number of low-end Android devices (retail
> price ~$30 USD in India, for example --- this set of customers is
> sometimes called "the next billion users" by some folks) that are
> using 32-bit ARM systems.  And they will be using ext4 or f2fs, and it
> would be massively unfortunate/unfair/etc. to impose that performance
> penalty on them.
>
> It sounds like what Willy is saying is that supporting a 64-bit page
> index on 32-bit platforms is going to be have a lot of downsides, and
> not just the performance / memory overhead issue.  It's also a code
> mainteinance concern, and that tax would land on the mm developers.
> And if it's not well-maintained, without regular testing, it's likely
> to be heavily subject to bitrot.  (Although I suppose if we don't mind
> doubling the number of configs that kernelci has to test, this could
> be mitigated.)
>
> In contrast, changing btrfs to not depend on a single address space
> for all of its metadata might be a lot of work, but it's something
> which lands on the btrfs developers, as opposed to a another (perhaps
> more central) kernel subsystem.  Managing at this tradeoff is
> something that is going to be between the mm developers and the btrfs
> developers, but as someone who doesn't do any work on either of these
> subsystems, it seems like a pretty obvious choice.

Yeah, I totally understand that.

And it doesn't look that worthy (or even possible) to make several
metadata inodes (address space to be more specific) just to support
32bit systemts.

As the lack of test coverage problem is still the same.

I don't see any active btrfs developer using 32bit system to test, even
for ARM systems.

Even rejecting the fs is in fact much more complex and may not get
enough tests after the initial submission.
>
> The final observation I'll make is that if we know which NAS box
> vendor can (properly) support volumes > 16 TB, we can probably find
> the 64-bit page index patch.  It'll probably be against a fairly old
> kernel, so it might not all _that_ helpful, but it might give folks a
> bit of a head start.
>
> I can tell you that the NAS box vendor that it _isn't_ is Synology.
> Synology boxes uses btrfs, and on 32-bit processors, they have a 16TB
> volume size limit, and this is enforced by the Synology NAS
> software[1].  However, Synology NAS boxes can support multiple
> volumes; until today, I never understood why, since it seemed to be
> unnecessary complexity, but I suspect the real answer was this was how
> Synology handled storage array sizes > 16TB on their older systems.
> (All of their new NAS boxes use 64-bit processors.)

BTW, even for Synology, 32bit systems can easily go beyond 16T in its
local address space while the underlying fs is only 1T or even smaller.

They only need to run routine balance and finally they will go beyond
that 16T limit.

Thanks,
Qu

>
> [1] https://www.reddit.com/r/synology/comments/a62xrx/max_volume_size_of=
_16tb/
>
> Cheers,
>
> 					- Ted
>
