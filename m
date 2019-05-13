Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B87631BBB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbfEMRUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 13:20:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41081 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfEMRUM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 13:20:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id y22so12226077qtn.8;
        Mon, 13 May 2019 10:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cUli1fY/TnRHw+1cITR1OZZRyWZTX1V9eLwDdv3i0gE=;
        b=hBdNBHMa0fxs+3kYZVBL7sxvvtlGe8C2rvbsD+8fpbC1gbVUbAq3/lyYvJ8IFxmY3V
         wZydL857hZYwrOw5/Zn5L7ViUVbohSC8DE+ghE1LsdDzvcKBd9Emt5AqOEM5uiSxnwH5
         GQ/Gns1l2FlhxSQtqX6BhGSYDd5Na/D7ufOowJ0Z1g1+kGrJS5rp3+uHYQn0tlT5GB2T
         TsdhnTpTl87DSGM9SjlQ2PA2KUCBQy42CO2dL+t2nCWkrZJ9jNxLY6q+mHGlWkpogn21
         KI3boxFJ0jWxYyOZVWd63F81Ubo1u3vklnwI4PBfX5pGQMAVAmuTdvinfpHKm/2WC12e
         7TFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cUli1fY/TnRHw+1cITR1OZZRyWZTX1V9eLwDdv3i0gE=;
        b=AxKDc+77EbRf2o2ACmZP4k8SAt/T60ZgsrwqYvaRgK4TXgBx/8LJxaZoEJIiKFK+HX
         8BcYYWZScIMFXPWECg4if5uc0RTg/kCs3d1/detlxwBUFS1olpfyO6hyE1Lxd509dDfj
         6VbBFfYe9VBPIFYXNjJlcu1n4pmS9n1SpUsFj6WlKhdlz/Dt3lXvOzQ0l9LBlP1gboDb
         TBBrlgXJ4DAq+o6/4wB5cJv7AQ4PY5gEi2ZMiRDCYVhvr9EeyZPGdaj9mb5z3BnyDXdn
         oLpJ7HiwHnP9YgJLZb+mM7s/cdWLxJjsCDWos7nOktOcQi1fZHAjENQluUkg/Kzm2GDx
         /bng==
X-Gm-Message-State: APjAAAWhd0V7WiwUQvrz49hRBUVAZltgIvXbKHzbCBNY5QCZy3RMeS7E
        YtJq0KtE1UPuFr+4rbXsVKU=
X-Google-Smtp-Source: APXvYqxfulJySZwj/ASlYebjYFH606pkE2LPTJDz57MhOJJS+nAp8G9BiFBXZjQmunDvq3trhlDtiA==
X-Received: by 2002:a0c:87f4:: with SMTP id 49mr23738749qvk.149.1557768010564;
        Mon, 13 May 2019 10:20:10 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d15sm7218285qko.77.2019.05.13.10.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:20:10 -0700 (PDT)
Date:   Mon, 13 May 2019 13:20:08 -0400
From:   Arvind Sankar <niveditas98@gmail.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Rob Landley <rob@landley.net>,
        Arvind Sankar <niveditas98@gmail.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        initramfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20190513172007.GA69717@rani.riverdale.lan>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 13, 2019 at 02:47:04PM +0200, Roberto Sassu wrote:
> On 5/13/2019 11:07 AM, Rob Landley wrote:
> > 
> > 
> > On 5/13/19 2:49 AM, Roberto Sassu wrote:
> >> On 5/12/2019 9:43 PM, Arvind Sankar wrote:
> >>> On Sun, May 12, 2019 at 05:05:48PM +0000, Rob Landley wrote:
> >>>> On 5/12/19 7:52 AM, Mimi Zohar wrote:
> >>>>> On Sun, 2019-05-12 at 11:17 +0200, Dominik Brodowski wrote:
> >>>>>> On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
> >>>>>>> This proposal consists in marshaling pathnames and xattrs in a file called
> >>>>>>> .xattr-list. They are unmarshaled by the CPIO parser after all files have
> >>>>>>> been extracted.
> >>>>>>
> >>>>>> Couldn't this parsing of the .xattr-list file and the setting of the xattrs
> >>>>>> be done equivalently by the initramfs' /init? Why is kernel involvement
> >>>>>> actually required here?
> >>>>>
> >>>>> It's too late.  The /init itself should be signed and verified.
> >>>>
> >>>> If the initramfs cpio.gz image was signed and verified by the extractor, how is
> >>>> the init in it _not_ verified?
> >>>>
> >>>> Ro
> >>>
> >>> Wouldn't the below work even before enforcing signatures on external
> >>> initramfs:
> >>> 1. Create an embedded initramfs with an /init that does the xattr
> >>> parsing/setting. This will be verified as part of the kernel image
> >>> signature, so no new code required.
> >>> 2. Add a config option/boot parameter to panic the kernel if an external
> >>> initramfs attempts to overwrite anything in the embedded initramfs. This
> >>> prevents overwriting the embedded /init even if the external initramfs
> >>> is unverified.
> >>
> >> Unfortunately, it wouldn't work. IMA is already initialized and it would
> >> verify /init in the embedded initial ram disk.
How does this work today then? Is it actually the case that initramfs
just cannot be used on an IMA-enabled system, or it can but it leaves
the initramfs unverified and we're trying to fix that? I had assumed the
latter.
> > 
> > So you made broken infrastructure that's causing you problems. Sounds unfortunate.
> 
> The idea is to be able to verify anything that is accessed, as soon as
> rootfs is available, without distinction between embedded or external
> initial ram disk.
> 
> Also, requiring an embedded initramfs for xattrs would be an issue for
> systems that use it for other purposes.
> 
The embedded initramfs can do other things, it just has to do
the xattr stuff in addition, no?
> 
> >> The only reason why
> >> opening .xattr-list works is that IMA is not yet initialized
> >> (late_initcall vs rootfs_initcall).
> > 
> > Launching init before enabling ima is bad because... you didn't think of it?
> 
> No, because /init can potentially compromise the integrity of the
> system.
> 
How? The /init in the embedded initramfs is part of a trusted kernel
image that has been verified by the bootloader.
> 
> >> Allowing a kernel with integrity enforcement to parse the CPIO image
> >> without verifying it first is the weak point.
> > 
> > If you don't verify the CPIO image then in theory it could have anything in it,
> > yes. You seem to believe that signing individual files is more secure than
> > signing the archive. This is certainly a point of view.
> 
> As I wrote above, signing the CPIO image would be more secure, if this
> option is available. However, a disadvantage would be that you have to
> sign the CPIO image every time a file changes.
> 
> 
> >> However, extracted files
> >> are not used, and before they are used they are verified. At the time
> >> they are verified, they (included /init) must already have a signature
> >> or otherwise access would be denied.
> > 
> > You build infrastructure that works a certain way, the rest of the system
> > doesn't fit your assumptions, so you need to change the rest of the system to
> > fit your assumptions.
> 
> Requiring file metadata to make decisions seems reasonable. Also
> mandatory access controls do that. The objective of this patch set is to
> have uniform behavior regardless of the filesystem used.
> 
> 
> >> This scheme relies on the ability of the kernel to not be corrupted in
> >> the event it parses a malformed CPIO image.
> > 
> > I'm unaware of any buffer overruns or wild pointer traversals in the cpio
> > extraction code. You can fill up all physical memory with initramfs and lock the
> > system hard, though.
> > 
> > It still only parses them at boot time before launching PID 1, right? So you
> > have a local physical exploit and you're trying to prevent people from working
> > around your Xbox copy protection without a mod chip?
> 
> What do you mean exactly?
> 
> 
> >> Mimi suggested to use
> >> digital signatures to prevent this issue, but it cannot be used in all
> >> scenarios, since conventional systems generate the initial ram disk
> >> locally.
> > 
> > So you use a proprietary init binary you can't rebuild from source, and put it
> > in a cpio where /dev/urandom is a file with known contents? Clearly, not
> > exploitable at all. (And we update the initramfs.cpio but not the kernel because
> > clearly keeping the kernel up to date is less important to security...)
> 
> By signing the CPIO image, the kernel wouldn't even attempt to parse it,
> as the image would be rejected by the boot loader if the signature is
> invalid.
> 
If it were signed yes, but you just said that it isn't possible to sign
it in all cases (if initramfs is generated locally). I actually didn't
follow that bit -- if initramfs is generated locally, and it isn't
possible to sign locally, where would the IMA hashes for the contents of
the initramfs come from? Is the idea that each file within the initramfs
would be an existing, signed, file, but you could locally create an initramfs
with some subset of those unmodified files? Even assuming this is the
case, isn't the eventual intention to also appraise directories, to
prevent holes where files might be moved around/deleted/renamed etc, so
this problem would resurface anyway?
Also eventually we need to check special nodes like device nodes etc to
make sure they haven't been tampered with, as in Rob's urandom
suggestion?
> 
> > Whatever happened to https://lwn.net/Articles/532778/ ? Modules are signed
> > in-band in the file, but you need xattrs for some reason?
> 
> Appending just the signature would be possible. It won't work if you
> have multiple metadata for the same file.
> 
> Also appending the signature alone won't solve the parsing issue. Still,
> the kernel has to parse something that could be malformed.
> 
> Roberto
> 
> 
> >> Roberto
> > 
> > Rob
> > 
> 
> -- 
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Bo PENG, Jian LI, Yanli SHI
