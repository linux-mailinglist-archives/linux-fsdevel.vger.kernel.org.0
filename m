Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED4651C2C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 08:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfENGFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 02:05:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43209 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENGFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 02:05:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id i8so14097090oth.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 23:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AqQ65aPmYBxs8YeWskKFAMy+/rvR1iTBTeI/KDee6BI=;
        b=11jt0n8/IROMtzDHHkPfYvfprknCVL6Sw4rb3FqQgUo0Km8SlE3E2tlWg/sFOSiOEI
         /sngiDQade3/jysV4lQHt2HIN0O/ISQJylHW3Ntgogi/lxMLxikjhBGg4fh0wsjuJAuT
         o5Bp4fFY1J5FO3FeRM2iS0s/qcmd1qHfbTlW0jZXXOLyAqsRP98w7opQ5RVnRK20XqpS
         ttx9zSe8pMSuExDE2P9ZFp3tzEtE6veshDq3D6/Xt8SIghurSuKhVQvfIaZ7ryui2mRK
         FKYf/3yLM8BVYfgSQeAVc9e6ik91AWFYuXecW1Ppx6usP1aWL7Z8pycC/5uZq86jI7vG
         BLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AqQ65aPmYBxs8YeWskKFAMy+/rvR1iTBTeI/KDee6BI=;
        b=BooZxjlzsaA+GL1EYY01ppM3fYlo95HzEgEpHGoPMSumwCirmxN8jn0e+ERPxJ13n1
         bdKQw+w/AmD8OQ90YDsGTKG3/lew7DGYLcmQeS5G5r0O28mTdc/+p0o/D64dqEilSm/3
         T690oHph/9DKgGp/m9wHhpDL4NfF9C2mpv+FN5l4aS1votRO5R6z9PiaZ8KfEWLz3Od2
         vpRll9BNxaBwNmTqwxAnEQgfPAXKRPRRZm4vsKmrC5nVSJTuznyOP64UTQvrWq712bRb
         L7sUPW1YRjfHEycvlcs/kmNba/pFEzzxC4ShrDMLluR/JbByj2pcPxyTKtu8mXxhLcah
         6rkw==
X-Gm-Message-State: APjAAAXIvahFQo+snrN42cIsfvNPKIU5w2wL0S7fNhOcnZx6hxlvl+bt
        OE+45J6OyNqt1xh5ntldJchO6g==
X-Google-Smtp-Source: APXvYqygXR6z3j+RrP+vgSO9TuCiHPxAW1p2ZKMvxwtViqw3ScnRL+lg5q/a8z6hEyxZ5rCIo6NC0g==
X-Received: by 2002:a9d:6852:: with SMTP id c18mr4577856oto.174.1557813934318;
        Mon, 13 May 2019 23:05:34 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id n185sm6025812oif.8.2019.05.13.23.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 23:05:33 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Arvind Sankar <niveditas98@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        initramfs@vger.kernel.org
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <49965ffd-dd57-ffe5-4a2f-73cdfb387848@landley.net>
Date:   Tue, 14 May 2019 01:06:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/13/19 7:47 AM, Roberto Sassu wrote:
> On 5/13/2019 11:07 AM, Rob Landley wrote:
>>>> Wouldn't the below work even before enforcing signatures on external
>>>> initramfs:
>>>> 1. Create an embedded initramfs with an /init that does the xattr
>>>> parsing/setting. This will be verified as part of the kernel image
>>>> signature, so no new code required.
>>>> 2. Add a config option/boot parameter to panic the kernel if an external
>>>> initramfs attempts to overwrite anything in the embedded initramfs. This
>>>> prevents overwriting the embedded /init even if the external initramfs
>>>> is unverified.
>>>
>>> Unfortunately, it wouldn't work. IMA is already initialized and it would
>>> verify /init in the embedded initial ram disk.
>>
>> So you made broken infrastructure that's causing you problems. Sounds
>> unfortunate.
> 
> The idea is to be able to verify anything that is accessed, as soon as
> rootfs is available, without distinction between embedded or external
> initial ram disk.

If /init is in the internal one and you can't overwrite files with an external
one, all your init has to be is something that applies the xattrs, enables your
paranoia mode, and then execs something else.

Heck, I do that sort of set up in shell scripts all the time. Running the shell
script as PID 1 and then having it exec the "real init" binary at the end:

https://github.com/landley/mkroot/blob/83def3cbae21/mkroot.sh#L205

If your first init binary is in the initramfs statically linked into the kernel
image, and the cpio code is doing open(O_EXCL), then it's as verified as any
other kernel code and runs "securely" until it decides to run something else.

> Also, requiring an embedded initramfs for xattrs would be an issue for
> systems that use it for other purposes.

I'm the guy who wrote the initmpfs code. (And has pending patches to improve it
that will probably never go upstream because I'm a hobbyist and dealing with the
 linux-kernel clique is the opposite of fun. I'm only in this conversation
because I was cc'd.)

You can totally use initramfs for lots of purposes simultaneously.

>>> The only reason why
>>> opening .xattr-list works is that IMA is not yet initialized
>>> (late_initcall vs rootfs_initcall).
>>
>> Launching init before enabling ima is bad because... you didn't think of it?
> 
> No, because /init can potentially compromise the integrity of the
> system.

Which isn't a problem if it was statically linked in the kernel, or if your
external cpio.gz was signed. You want a signed binary but don't want the
signature _in_ the binary...

>>> Allowing a kernel with integrity enforcement to parse the CPIO image
>>> without verifying it first is the weak point.
>>
>> If you don't verify the CPIO image then in theory it could have anything in it,
>> yes. You seem to believe that signing individual files is more secure than
>> signing the archive. This is certainly a point of view.
> 
> As I wrote above, signing the CPIO image would be more secure, if this
> option is available. However, a disadvantage would be that you have to
> sign the CPIO image every time a file changes.

Which is why there's a cpio in the kernel and an external cpio loaded via the
old initrd mechanism and BOTH files wind up in the cpio and there's a way to
make it O_EXCL so it can't overwrite, and then the /init binary inside the
kernel's cpio can do any other weird verification you need to do before anything
else gets a chance to run so why are you having ring 0 kernel code read a file
out of the filesystem and act upon it?

(Heck, you can mv /newinit /init before the exec /init so the file isn't on the
system anymore by the time the other stuff gets to run...)

>>> However, extracted files
>>> are not used, and before they are used they are verified. At the time
>>> they are verified, they (included /init) must already have a signature
>>> or otherwise access would be denied.
>>
>> You build infrastructure that works a certain way, the rest of the system
>> doesn't fit your assumptions, so you need to change the rest of the system to
>> fit your assumptions.
> 
> Requiring file metadata to make decisions seems reasonable. Also
> mandatory access controls do that. The objective of this patch set is to
> have uniform behavior regardless of the filesystem used.

If it's in the file's contents you get uniform behavior regardless of the
filesystem used. And "mandatory access controls do that" is basically restating
what _I_ said in the paragraph above.

The "infrastructure you have that works a certain way" is called "mandatory
access controls". Good to know. Your patch changes the rest of the system to
match the assumptions of the new code, because changing those assumptions
appears literally unthinkable.

>>> This scheme relies on the ability of the kernel to not be corrupted in
>>> the event it parses a malformed CPIO image.
>>
>> I'm unaware of any buffer overruns or wild pointer traversals in the cpio
>> extraction code. You can fill up all physical memory with initramfs and lock the
>> system hard, though.
>>
>> It still only parses them at boot time before launching PID 1, right? So you
>> have a local physical exploit and you're trying to prevent people from working
>> around your Xbox copy protection without a mod chip?
> 
> What do you mean exactly?

That you're not remotely the first person to do this?

You're attempting to prevent anyone from running third party code on your system
without buying a license from you first. You're creating a system with no user
serviceable parts, that only runs authorized software from the Apple Store or
other walled garden. No sideloading allowed.

Which is your choice, sure. But why do you need new infrastructure to do it?
People have already _done_ this. They're just by nature proprietary and don't
like sharing with the group when not forced by lawyers, so they come up with
ways that don't involve modifying GPLv2 software (or shipping GPLv3 software,
ever, for any reason).

>>> Mimi suggested to use
>>> digital signatures to prevent this issue, but it cannot be used in all
>>> scenarios, since conventional systems generate the initial ram disk
>>> locally.
>>
>> So you use a proprietary init binary you can't rebuild from source, and put it
>> in a cpio where /dev/urandom is a file with known contents? Clearly, not
>> exploitable at all. (And we update the initramfs.cpio but not the kernel because
>> clearly keeping the kernel up to date is less important to security...)
> 
> By signing the CPIO image, the kernel wouldn't even attempt to parse it,
> as the image would be rejected by the boot loader if the signature is
> invalid.

So you have _more_ assumptions tripping you up. Great. So add a signature in a
format your bootloader doesn't recognize, since it's the kernel that should
verify it, not your bootloader?

It sounds like your problem is bureaucratic, not technical.

>> Whatever happened to https://lwn.net/Articles/532778/ ? Modules are signed
>> in-band in the file, but you need xattrs for some reason?
> 
> Appending just the signature would be possible. It won't work if you
> have multiple metadata for the same file.

Call the elf sections SIG1 SIG2 SIG3, or have a section full of keyword=value
strings? How is this a hard problem?

> Also appending the signature alone won't solve the parsing issue. Still,
> the kernel has to parse something that could be malformed.

Your new in-band signaling file you're making xattrs from could be malformed,
one of the xattrs you add could be "banana=aaaaaaaaaaaaaaaaaaaaaaaaaaa..." going
on for 12 megabytes...

Rob
