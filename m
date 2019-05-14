Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A16F1CBD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfENP1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 11:27:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33154 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfENP1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 11:27:08 -0400
Received: by mail-qk1-f195.google.com with SMTP id k189so10565698qkc.0;
        Tue, 14 May 2019 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KCOgmDiYMtUV2Q3RZKLwn2QBDsNpWEG4E/kygsBFgEY=;
        b=Be3Ca5LnZsIUAnWIoL3ZyKn2Rceb120PSlDJm/Yj0ACq33v3VYgPrvwAlBlSyJdKPP
         1oVUUBnxxdWEpTSLkuYOfythgOORcVSUcJC3uwa2S2qDXUxltRuIXd/blx3oM1EjfBkg
         EIkozRGOc53aQWnwZK5Ni3BBLdG2NVjo6NPefQ8pL7YLPfbdO4tWB/YMNcmmvGbdGQAZ
         m3YuN+iPm2SRu51HH0u03fl8juIbduAIMKRJPAkeshSypeAhBQEDUY/uSYrryfCqkZAR
         jVqy/5kMpWEE0myIu5o0jiYHZFmE8RFmUspJmWixSUV/ka+8z+REHkwE3uoCHvZRS2LH
         /wlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KCOgmDiYMtUV2Q3RZKLwn2QBDsNpWEG4E/kygsBFgEY=;
        b=OQu9yj6H5Q+EElT+Vs47s/QON6SJvx247IhPIN9RCwyGNSxckZtOQJt7ZNCw0D45K/
         sRa2eIIh6RJ+1FcbWX1vC9KwkwvNPmYuniQeCM9rbojUPFLfKrU2r8y77bEjf9j3ct9m
         JKHcji5AnnNJ2Fc4ciZBjpYuTWWOTdMdD+2/4VBfzkslu0mFPS7cfTl6dJZD4Bwey3VA
         1n6jsosj4LkPBarW9JDAHuRSHAfjIYZvr1TfhLg0pXDtKkulok7lUWoqeAaUZYdrPNUn
         Wq6xWM91tmKinxPYCNs8aGptljnrs3PPOsaU9KbV8qaavOnOB4gw4sEDGitdIvRs2t13
         VwIw==
X-Gm-Message-State: APjAAAWBph/KfBuhg9h4S4uryXvUy3pcI7GGOaHwMeMUPmiUH3AUmHOg
        Z1rfJoD0oYPqnkGVyDl8VRA=
X-Google-Smtp-Source: APXvYqysHP5PaKcK4UT6OkMoQVOci2TUpd+0nIwkrx6nQzISnjtBmZ597O/IYBWy66xsWRBxFEK1ZA==
X-Received: by 2002:a37:8544:: with SMTP id h65mr28577635qkd.84.1557847626916;
        Tue, 14 May 2019 08:27:06 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g12sm9082088qkk.88.2019.05.14.08.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 08:27:06 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 May 2019 11:27:04 -0400
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Rob Landley <rob@landley.net>,
        Arvind Sankar <niveditas98@gmail.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        initramfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20190514152704.GB37109@rani.riverdale.lan>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <49965ffd-dd57-ffe5-4a2f-73cdfb387848@landley.net>
 <de91ef53-6bb3-b937-8773-5f6b34e1acb7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de91ef53-6bb3-b937-8773-5f6b34e1acb7@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 14, 2019 at 01:52:42PM +0200, Roberto Sassu wrote:
> On 5/14/2019 8:06 AM, Rob Landley wrote:
> > On 5/13/19 7:47 AM, Roberto Sassu wrote:
> >> On 5/13/2019 11:07 AM, Rob Landley wrote:
> >>>>> Wouldn't the below work even before enforcing signatures on external
> >>>>> initramfs:
> >>>>> 1. Create an embedded initramfs with an /init that does the xattr
> >>>>> parsing/setting. This will be verified as part of the kernel image
> >>>>> signature, so no new code required.
> >>>>> 2. Add a config option/boot parameter to panic the kernel if an external
> >>>>> initramfs attempts to overwrite anything in the embedded initramfs. This
> >>>>> prevents overwriting the embedded /init even if the external initramfs
> >>>>> is unverified.
> >>>>
> >>>> Unfortunately, it wouldn't work. IMA is already initialized and it would
> >>>> verify /init in the embedded initial ram disk.
> >>>
> >>> So you made broken infrastructure that's causing you problems. Sounds
> >>> unfortunate.
> >>
> >> The idea is to be able to verify anything that is accessed, as soon as
> >> rootfs is available, without distinction between embedded or external
> >> initial ram disk.
> > 
> > If /init is in the internal one and you can't overwrite files with an external
> > one, all your init has to be is something that applies the xattrs, enables your
> > paranoia mode, and then execs something else.
> 
> Shouldn't file metadata be handled by the same code that extracts the
> content? Instead, file content is extracted by the kernel, and we are
> adding another step to the boot process, to execute a new binary with a
> link to libc.
> 
>  From the perspective of a remote verifier that checks the software
> running on the system, would it be easier to check less than 150 lines
> of code, or a CPIO image containing a binary + libc?
> 
Isn't the remote attestation process just involving the boot measurement
to verify that software has not changed, not actually reviewing the
code? How does it matter what's inside the kernel image as long as we
know it hasn't changed from when it was installed?
You don't need much of a libc in any case -- the userspace code is not
going to be doing anything different from what you're proposing to do
inside the kernel, and I would expect the userland code to be
easier to test and verify for correctness than code embedded in the
kernel's boot process. It shouldn't be any more complex than the kernel
version.
It's also much easier to change/customize it for the end
system's requirements rather than setting the process in stone by
putting it inside the kernel.
> 
> > Heck, I do that sort of set up in shell scripts all the time. Running the shell
> > script as PID 1 and then having it exec the "real init" binary at the end:
> > 
> > https://github.com/landley/mkroot/blob/83def3cbae21/mkroot.sh#L205
> > 
> > If your first init binary is in the initramfs statically linked into the kernel
> > image, and the cpio code is doing open(O_EXCL), then it's as verified as any
> > other kernel code and runs "securely" until it decides to run something else.
> > 
> >> Also, requiring an embedded initramfs for xattrs would be an issue for
> >> systems that use it for other purposes.
> > 
> > I'm the guy who wrote the initmpfs code. (And has pending patches to improve it
> > that will probably never go upstream because I'm a hobbyist and dealing with the
> >   linux-kernel clique is the opposite of fun. I'm only in this conversation
> > because I was cc'd.)
> > 
> > You can totally use initramfs for lots of purposes simultaneously.
> 
> Yes, I agree. However, adding an initramfs to initialize another
> initramfs when you can simply extract file content and metadata with the
> same parser, this for me it is difficult to justify.
> 
It's not really the same parser, right? It's just code that runs after
the parser is done, and the question is whether that code needs to live
inside the kernel or can be done in userspace.
> 
> >>>> The only reason why
> >>>> opening .xattr-list works is that IMA is not yet initialized
> >>>> (late_initcall vs rootfs_initcall).
> >>>
> >>> Launching init before enabling ima is bad because... you didn't think of it?
> >>
> >> No, because /init can potentially compromise the integrity of the
> >> system.
> > 
> > Which isn't a problem if it was statically linked in the kernel, or if your
> > external cpio.gz was signed. You want a signed binary but don't want the
> > signature _in_ the binary...
> 
> It is not just for binaries. How you would deal with arbitrary file
> formats?
> 
> 
> >>>> Allowing a kernel with integrity enforcement to parse the CPIO image
> >>>> without verifying it first is the weak point.
> >>>
> >>> If you don't verify the CPIO image then in theory it could have anything in it,
> >>> yes. You seem to believe that signing individual files is more secure than
> >>> signing the archive. This is certainly a point of view.
> >>
> >> As I wrote above, signing the CPIO image would be more secure, if this
> >> option is available. However, a disadvantage would be that you have to
> >> sign the CPIO image every time a file changes.
> > 
> > Which is why there's a cpio in the kernel and an external cpio loaded via the
> > old initrd mechanism and BOTH files wind up in the cpio and there's a way to
> > make it O_EXCL so it can't overwrite, and then the /init binary inside the
> > kernel's cpio can do any other weird verification you need to do before anything
> > else gets a chance to run so why are you having ring 0 kernel code read a file
> > out of the filesystem and act upon it?
> 
> The CPIO parser already invokes many system calls.
> 
> 
> > (Heck, you can mv /newinit /init before the exec /init so the file isn't on the
> > system anymore by the time the other stuff gets to run...)
> > 
> >>>> However, extracted files
> >>>> are not used, and before they are used they are verified. At the time
> >>>> they are verified, they (included /init) must already have a signature
> >>>> or otherwise access would be denied.
> >>>
> >>> You build infrastructure that works a certain way, the rest of the system
> >>> doesn't fit your assumptions, so you need to change the rest of the system to
> >>> fit your assumptions.
> >>
> >> Requiring file metadata to make decisions seems reasonable. Also
> >> mandatory access controls do that. The objective of this patch set is to
> >> have uniform behavior regardless of the filesystem used.
> > 
> > If it's in the file's contents you get uniform behavior regardless of the
> > filesystem used. And "mandatory access controls do that" is basically restating
> > what _I_ said in the paragraph above.
> 
> As I said, that does not work with arbitrary file formats.
> 
> 
> > The "infrastructure you have that works a certain way" is called "mandatory
> > access controls". Good to know. Your patch changes the rest of the system to
> > match the assumptions of the new code, because changing those assumptions
> > appears literally unthinkable.
> 
> All I want to do is to have the same behavior as if there is no initial
> ram disk. And given that inode-based MACs read the labels from xattrs,
> the assumption that the system provides xattrs even in the inital ram
> disk seems reasonable.
> 
> 
> >>>> This scheme relies on the ability of the kernel to not be corrupted in
> >>>> the event it parses a malformed CPIO image.
> >>>
> >>> I'm unaware of any buffer overruns or wild pointer traversals in the cpio
> >>> extraction code. You can fill up all physical memory with initramfs and lock the
> >>> system hard, though.
> >>>
> >>> It still only parses them at boot time before launching PID 1, right? So you
> >>> have a local physical exploit and you're trying to prevent people from working
> >>> around your Xbox copy protection without a mod chip?
> >>
> >> What do you mean exactly?
> > 
> > That you're not remotely the first person to do this?
> > 
> > You're attempting to prevent anyone from running third party code on your system
> > without buying a license from you first. You're creating a system with no user
> > serviceable parts, that only runs authorized software from the Apple Store or
> > other walled garden. No sideloading allowed.
> 
> This is one use case. The main purpose of IMA is to preserve the
> integrity of the Trusted Computing Base (TCB, the critical part of the
> system), or to detect integrity violations without enforcement. This is
> done by ensuring that the software comes from the vendor. Applications
> owned by users are allowed to run, as the Discrectionary Access Control
> (DAC) prevents attacks to the TCB. I'm working on a more advanced scheme
> that relies on MAC.
> 
> 
> > Which is your choice, sure. But why do you need new infrastructure to do it?
> > People have already _done_ this. They're just by nature proprietary and don't
> > like sharing with the group when not forced by lawyers, so they come up with
> > ways that don't involve modifying GPLv2 software (or shipping GPLv3 software,
> > ever, for any reason).
> > 
> >>>> Mimi suggested to use
> >>>> digital signatures to prevent this issue, but it cannot be used in all
> >>>> scenarios, since conventional systems generate the initial ram disk
> >>>> locally.
> >>>
> >>> So you use a proprietary init binary you can't rebuild from source, and put it
> >>> in a cpio where /dev/urandom is a file with known contents? Clearly, not
> >>> exploitable at all. (And we update the initramfs.cpio but not the kernel because
> >>> clearly keeping the kernel up to date is less important to security...)
> >>
> >> By signing the CPIO image, the kernel wouldn't even attempt to parse it,
> >> as the image would be rejected by the boot loader if the signature is
> >> invalid.
> > 
> > So you have _more_ assumptions tripping you up. Great. So add a signature in a
> > format your bootloader doesn't recognize, since it's the kernel that should
> > verify it, not your bootloader?
> > 
> > It sounds like your problem is bureaucratic, not technical.
> 
> The boot loader verifies the CPIO image, when this is possible. The
> kernel verifies individual files when the CPIO image is not signed.
> 
> If a remote verifier wants to verify the measurement of the CPIO image,
> and he only has reference digests for each file, he has to build the
> CPIO image with files reference digests were calculated from, and in the
> same way it was done by the system target of the evaluation.
> 
> 
> >>> Whatever happened to https://lwn.net/Articles/532778/ ? Modules are signed
> >>> in-band in the file, but you need xattrs for some reason?
> >>
> >> Appending just the signature would be possible. It won't work if you
> >> have multiple metadata for the same file.
> > 
> > Call the elf sections SIG1 SIG2 SIG3, or have a section full of keyword=value
> > strings? How is this a hard problem?
> > 
> >> Also appending the signature alone won't solve the parsing issue. Still,
> >> the kernel has to parse something that could be malformed.
> > 
> > Your new in-band signaling file you're making xattrs from could be malformed,
> > one of the xattrs you add could be "banana=aaaaaaaaaaaaaaaaaaaaaaaaaaa..." going
> > on for 12 megabytes...
> 
> ksys_lsetxattr() checks the limits.
> 
> Roberto
> 
> 
> > Rob
> > 
> 
> -- 
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Bo PENG, Jian LI, Yanli SHI
