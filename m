Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D4D1CB7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfENPMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 11:12:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45413 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENPMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 11:12:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id t24so6843051otl.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FrpMwftM+Mr1Vog1ubFtZ/Eq4Iaee6jzdfGfMeP7N9s=;
        b=pJmHxmx6dWkcghgKrC5HPlV8gxpzuFwGHMNwCUJPC0PmpEocXwk43PwXNOGP/Zuore
         Mzg4B6hN0i1zDBRzZ6wiPlBU3Sqg8zyZ9m7eEmWFNj/RMGSJ75tEYa24hRm3M5rhcaZQ
         sOV/dSTJMCCpduTyjh83RvfxFLSQl0uoMErJbnnICChcreDI+l2OBZ28+ax9c/3k1PET
         +Ci8OHc6VhQgMa1phIs1yh0ddmWHTZysZDx9MwL//nKTf/IO9EsQL8Fq24/gY1DfPHX4
         lfVobhVcqf3JcdHfND1D/KCa33MaF1cxMWFY+9wfcGVw91uCSBzOaDlQohfHx+v5HvSB
         KI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FrpMwftM+Mr1Vog1ubFtZ/Eq4Iaee6jzdfGfMeP7N9s=;
        b=MPawYDkBhxbY4O5OymvZ/YRqediLuq7TgJ5wWRgOF1xaZ25vNwBx1fgyBxn9/HFI56
         CfOgUBEIl5kfebICLTLqcx7RJFMf6kU1kZbL6vz7qS2XYR3GAjkEv9hCjB47nWeXc11Q
         x9O05T+yZGNCzWnIcdu4n9ZTs8G/rAwSXcbMcEhdnh3ErT64FDOIWSQ7xsdtGkqV94wA
         yTLt0OEUTSqakfTRyB/QtTi5kjGS+3Cqws52IFsjY4xPLEuH8KBQZRnT/i5EeBU3tvE7
         Tuf1j1NO436KTb7wuzB2TPCeAwP0ZoBOcm/bAJyoP96z4yZzX77MTURlETjWjKNVvjSO
         685g==
X-Gm-Message-State: APjAAAURHtVPf8UwxKMU36Wj+N6g/SANQbJGgTcAomza7FTB75/aQpVu
        KPFMFXs/jARukBvouG/gKXR6fQ==
X-Google-Smtp-Source: APXvYqxBE5qHNnI7jn0KhYXZ0u5z/o8iGkGomskLiMImbtrPbRrmdb7eWuAKzghEbo9h6QlD10Q6tw==
X-Received: by 2002:a9d:826:: with SMTP id 35mr21646474oty.114.1557846725044;
        Tue, 14 May 2019 08:12:05 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id q205sm6338464oih.17.2019.05.14.08.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 08:12:04 -0700 (PDT)
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
 <49965ffd-dd57-ffe5-4a2f-73cdfb387848@landley.net>
 <de91ef53-6bb3-b937-8773-5f6b34e1acb7@huawei.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <6dcf4759-de65-d427-03c7-4b3df361da18@landley.net>
Date:   Tue, 14 May 2019 10:12:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <de91ef53-6bb3-b937-8773-5f6b34e1acb7@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/14/19 6:52 AM, Roberto Sassu wrote:
> On 5/14/2019 8:06 AM, Rob Landley wrote:
>> On 5/13/19 7:47 AM, Roberto Sassu wrote:
>>> On 5/13/2019 11:07 AM, Rob Landley wrote:
>>>>>> Wouldn't the below work even before enforcing signatures on external
>>>>>> initramfs:
>>>>>> 1. Create an embedded initramfs with an /init that does the xattr
>>>>>> parsing/setting. This will be verified as part of the kernel image
>>>>>> signature, so no new code required.
>>>>>> 2. Add a config option/boot parameter to panic the kernel if an external
>>>>>> initramfs attempts to overwrite anything in the embedded initramfs. This
>>>>>> prevents overwriting the embedded /init even if the external initramfs
>>>>>> is unverified.
>>>>>
>>>>> Unfortunately, it wouldn't work. IMA is already initialized and it would
>>>>> verify /init in the embedded initial ram disk.
>>>>
>>>> So you made broken infrastructure that's causing you problems. Sounds
>>>> unfortunate.
>>>
>>> The idea is to be able to verify anything that is accessed, as soon as
>>> rootfs is available, without distinction between embedded or external
>>> initial ram disk.
>>
>> If /init is in the internal one and you can't overwrite files with an external
>> one, all your init has to be is something that applies the xattrs, enables your
>> paranoia mode, and then execs something else.
> 
> Shouldn't file metadata be handled by the same code that extracts the
> content? Instead, file content is extracted by the kernel, and we are
> adding another step to the boot process, to execute a new binary with a
> link to libc.

I haven't made a dynamically linked initramfs in years (except a couple for
testing purposes). But then I don't deploy glibc, so...

> From the perspective of a remote verifier that checks the software
> running on the system, would it be easier to check less than 150 lines
> of code, or a CPIO image containing a binary + libc?

https://github.com/torvalds/linux/blob/master/tools/include/nolibc/nolibc.h

(I have a todo item to add sh4 and m68k and ppc and such sections to that, but
see "I've needed to resubmit
http://lkml.iu.edu/hypermail/linux/kernel/1709.1/03561.html for a couple years
now but it works for me locally and dealing with linux-kernel is just no fun
anymore"...)

>> You can totally use initramfs for lots of purposes simultaneously.
> 
> Yes, I agree. However, adding an initramfs to initialize another
> initramfs when you can simply extract file content and metadata with the
> same parser, this for me it is difficult to justify.

You just said it's simpler to modify the kernel than do a thing you can already
do in userspace. You realize that, right?

>>>>> The only reason why
>>>>> opening .xattr-list works is that IMA is not yet initialized
>>>>> (late_initcall vs rootfs_initcall).
>>>>
>>>> Launching init before enabling ima is bad because... you didn't think of it?
>>>
>>> No, because /init can potentially compromise the integrity of the
>>> system.
>>
>> Which isn't a problem if it was statically linked in the kernel, or if your
>> external cpio.gz was signed. You want a signed binary but don't want the
>> signature _in_ the binary...
> 
> It is not just for binaries. How you would deal with arbitrary file
> formats?

I'm confused, are you saying that /init can/should be an arbitrary file format,
or that a cpio statically linked into the kernel can't contain files in
arbitrary formats?

>> Which is why there's a cpio in the kernel and an external cpio loaded via the
>> old initrd mechanism and BOTH files wind up in the cpio and there's a way to
>> make it O_EXCL so it can't overwrite, and then the /init binary inside the
>> kernel's cpio can do any other weird verification you need to do before anything
>> else gets a chance to run so why are you having ring 0 kernel code read a file
>> out of the filesystem and act upon it?
> 
> The CPIO parser already invokes many system calls.

The one in the kernel doesn't call system calls, no. Once userspace is running
it can do what it likes. The one statically linked into the kernel was set up by
the same people who built the kernel; if you're letting arbitrary kernels run on
your system it's kinda over already from a security context?

>> If it's in the file's contents you get uniform behavior regardless of the
>> filesystem used. And "mandatory access controls do that" is basically restating
>> what _I_ said in the paragraph above.
> 
> As I said, that does not work with arbitrary file formats.

an /init binary can parse your .inbandsignalling file to apply xattrs to
arbitrary files before handing off to something else, and a cpio.gz statically
linked into the kernel can contain arbitrary files.

>> The "infrastructure you have that works a certain way" is called "mandatory
>> access controls". Good to know. Your patch changes the rest of the system to
>> match the assumptions of the new code, because changing those assumptions
>> appears literally unthinkable.
> 
> All I want to do is to have the same behavior as if there is no initial
> ram disk. And given that inode-based MACs read the labels from xattrs,
> the assumption that the system provides xattrs even in the inital ram
> disk seems reasonable.

There was a previous proposal for a new revision of cpio that I don't remember
particularly objecting to? Which did things that can't trivially be done in
userspace?

>>> What do you mean exactly?
>>
>> That you're not remotely the first person to do this?
>>
>> You're attempting to prevent anyone from running third party code on your system
>> without buying a license from you first. You're creating a system with no user
>> serviceable parts, that only runs authorized software from the Apple Store or
>> other walled garden. No sideloading allowed.
> 
> This is one use case. The main purpose of IMA is to preserve the
> integrity of the Trusted Computing Base (TCB, the critical part of the
> system), or to detect integrity violations without enforcement. This is
> done by ensuring that the software comes from the vendor. Applications
> owned by users are allowed to run, as the Discrectionary Access Control
> (DAC) prevents attacks to the TCB. I'm working on a more advanced scheme
> that relies on MAC.

Sure, same general idea as Apple's lobbying against "right to repair".

https://appleinsider.com/articles/19/03/18/california-reintroduces-right-to-repair-bill-after-previous-effort-failed

The vendor can prevent any unauthorized software from running on the device, or
even retroactively remove older software to force upgrades:

https://www.macrumors.com/2019/05/13/adobe-creative-cloud-legal-action-older-apps/

Or anything else, of course:

https://www.zdnet.com/article/why-amazon-is-within-its-rights-to-remove-access-to-your-kindle-books/

*shrug* Your choice, of course...

>> So you have _more_ assumptions tripping you up. Great. So add a signature in a
>> format your bootloader doesn't recognize, since it's the kernel that should
>> verify it, not your bootloader?
>>
>> It sounds like your problem is bureaucratic, not technical.
> 
> The boot loader verifies the CPIO image, when this is possible. The
> kernel verifies individual files when the CPIO image is not signed.
> 
> If a remote verifier wants to verify the measurement of the CPIO image,
> and he only has reference digests for each file, he has to build the
> CPIO image with files reference digests were calculated from, and in the
> same way it was done by the system target of the evaluation.

And your init program can parse your .inbandsignaling file to put the xattrs on
the files and then poke the "now enforce" button.

>>>> Whatever happened to https://lwn.net/Articles/532778/ ? Modules are signed
>>>> in-band in the file, but you need xattrs for some reason?
>>>
>>> Appending just the signature would be possible. It won't work if you
>>> have multiple metadata for the same file.
>>
>> Call the elf sections SIG1 SIG2 SIG3, or have a section full of keyword=value
>> strings? How is this a hard problem?
>>
>>> Also appending the signature alone won't solve the parsing issue. Still,
>>> the kernel has to parse something that could be malformed.
>>
>> Your new in-band signaling file you're making xattrs from could be malformed,
>> one of the xattrs you add could be "banana=aaaaaaaaaaaaaaaaaaaaaaaaaaa..." going
>> on for 12 megabytes...
> 
> ksys_lsetxattr() checks the limits.

Not if it caused an oom error extracting your .inbandsignaling file before it
got consumed. (The kernel has to parse something that could be malformed and
that's bad reading ELF information like linux has done loading binaries since
1996, but it's ok for xattrs with a system call?)

*shrug* I've made my opinion clear and don't think this thread is useful at this
point, I'm not the maintainer with merge authority, so I'm gonna mute it now.

Rob
