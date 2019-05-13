Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87CC51BC50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 19:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbfEMRw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 13:52:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38397 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbfEMRwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 13:52:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so8666308qth.5;
        Mon, 13 May 2019 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LDbQfP6zFs00yM0BuuWdblWsKRTzaG/CBEDU7dZNmDs=;
        b=O5I4PGBL5IzNYv6Bq/wm2zwG3SzvtCI2bDBMnnKtCWU0zVguqAGvTiJ9H4ctz0WqRh
         4KziU4mHqSiT3VK5ukyN08yx59j3RYqONk0TPJLRrMIXEAFhx35GId04T+JshsoNnNXs
         ubteBEW//t4bbkFCBV5zGY67+Z6gdacDMWmER+n0KV1C46NO4T8LVDx7O/LTqgpKk3EJ
         xuNhwFmg9f0Qq3EjrwraZaKcniI9ZyalKzUU0B/hmBBgZ4L3ykSSTJ/+D4rs+avO+7g5
         pZY4bZBPBUyq0Eh6vkpBM4qHmbmPulnD4CwSjneTocgEfWVvfhzQZlV21f/srvzi1Wlg
         lSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LDbQfP6zFs00yM0BuuWdblWsKRTzaG/CBEDU7dZNmDs=;
        b=BijamBKAfPXojnU2tMM113PwHjGmPEPcP65nJgGQeOhVnsh4Lm7cKDp6eELCzqPVoH
         QcZ2/zxpaWRFXNktdn78kfKCFQ4WqFaKTyDtcSAsmwPibGPdbpgTTznNtHf/QGabOo59
         8xCchLRKMBMre2sH8oe1+cfjvuzSExyxWFPYKeu35d8vYN7eyxPGS1Fi2EjVkk0s62mS
         vQezI4zTbZcHKaAyEjpV3SUkgiEy4BP4A72LyrA/lGCyxgB4+bjiTDos+CdXqBV1aNVs
         uV1EpFmrc7jDA71BPALQ2vOcWywkbw+tzrLLxciW7Y4vwca1EGLYgLHv+7tFmH/p2+sK
         ZoDw==
X-Gm-Message-State: APjAAAUtMBycQ5wMd8FHjW3jD4vcTNMhSOEt9gTqW2hwZ4o1j0f/Qx/K
        EU2a2eopI9mV5j4kdyQ8alA=
X-Google-Smtp-Source: APXvYqxQ4jtZobe2yh+82a4z1VRak83xYjV5aZ6fxvr1TTTEUQbtS1OcsUXJPViceQ5Ph2wxhZcB9g==
X-Received: by 2002:a0c:9679:: with SMTP id 54mr12480342qvy.168.1557769972483;
        Mon, 13 May 2019 10:52:52 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t124sm7183371qkh.29.2019.05.13.10.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:52:52 -0700 (PDT)
Date:   Mon, 13 May 2019 13:52:50 -0400
From:   Arvind Sankar <niveditas98@gmail.com>
To:     Arvind Sankar <niveditas98@gmail.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20190513175250.GC69717@rani.riverdale.lan>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <20190513172007.GA69717@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190513172007.GA69717@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 13, 2019 at 01:20:08PM -0400, Arvind Sankar wrote:
> On Mon, May 13, 2019 at 02:47:04PM +0200, Roberto Sassu wrote:
> > On 5/13/2019 11:07 AM, Rob Landley wrote:
> > > 
> > > 
> > > On 5/13/19 2:49 AM, Roberto Sassu wrote:
> > >> On 5/12/2019 9:43 PM, Arvind Sankar wrote:
> > >>> On Sun, May 12, 2019 at 05:05:48PM +0000, Rob Landley wrote:
> > >>>> On 5/12/19 7:52 AM, Mimi Zohar wrote:
> > >>>>> On Sun, 2019-05-12 at 11:17 +0200, Dominik Brodowski wrote:
> > >>>>>> On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
> > >>>>>>> This proposal consists in marshaling pathnames and xattrs in a file called
> > >>>>>>> .xattr-list. They are unmarshaled by the CPIO parser after all files have
> > >>>>>>> been extracted.
> > >>>>>>
> > >>>>>> Couldn't this parsing of the .xattr-list file and the setting of the xattrs
> > >>>>>> be done equivalently by the initramfs' /init? Why is kernel involvement
> > >>>>>> actually required here?
> > >>>>>
> > >>>>> It's too late.  The /init itself should be signed and verified.
> > >>>>
> > >>>> If the initramfs cpio.gz image was signed and verified by the extractor, how is
> > >>>> the init in it _not_ verified?
> > >>>>
> > >>>> Ro
> > >>>
> > >>> Wouldn't the below work even before enforcing signatures on external
> > >>> initramfs:
> > >>> 1. Create an embedded initramfs with an /init that does the xattr
> > >>> parsing/setting. This will be verified as part of the kernel image
> > >>> signature, so no new code required.
> > >>> 2. Add a config option/boot parameter to panic the kernel if an external
> > >>> initramfs attempts to overwrite anything in the embedded initramfs. This
> > >>> prevents overwriting the embedded /init even if the external initramfs
> > >>> is unverified.
> > >>
> > >> Unfortunately, it wouldn't work. IMA is already initialized and it would
> > >> verify /init in the embedded initial ram disk.
> How does this work today then? Is it actually the case that initramfs
> just cannot be used on an IMA-enabled system, or it can but it leaves
> the initramfs unverified and we're trying to fix that? I had assumed the
> latter.
Oooh, it's done not by starting IMA appraisal later, but by loading a
default policy to ignore initramfs?
> > > 
> > > So you made broken infrastructure that's causing you problems. Sounds unfortunate.
> > 
> > The idea is to be able to verify anything that is accessed, as soon as
> > rootfs is available, without distinction between embedded or external
> > initial ram disk.
> > 
> > Also, requiring an embedded initramfs for xattrs would be an issue for
> > systems that use it for other purposes.
> > 
> The embedded initramfs can do other things, it just has to do
> the xattr stuff in addition, no?
> > 
> > >> The only reason why
> > >> opening .xattr-list works is that IMA is not yet initialized
> > >> (late_initcall vs rootfs_initcall).
> > > 
> > > Launching init before enabling ima is bad because... you didn't think of it?
> > 
> > No, because /init can potentially compromise the integrity of the
> > system.
> > 
> How? The /init in the embedded initramfs is part of a trusted kernel
> image that has been verified by the bootloader.
> > 
> > >> Allowing a kernel with integrity enforcement to parse the CPIO image
> > >> without verifying it first is the weak point.
> > > 
> > > If you don't verify the CPIO image then in theory it could have anything in it,
> > > yes. You seem to believe that signing individual files is more secure than
> > > signing the archive. This is certainly a point of view.
> > 
> > As I wrote above, signing the CPIO image would be more secure, if this
> > option is available. However, a disadvantage would be that you have to
> > sign the CPIO image every time a file changes.
> > 
> > 
> > >> However, extracted files
> > >> are not used, and before they are used they are verified. At the time
> > >> they are verified, they (included /init) must already have a signature
> > >> or otherwise access would be denied.
> > > 
> > > You build infrastructure that works a certain way, the rest of the system
> > > doesn't fit your assumptions, so you need to change the rest of the system to
> > > fit your assumptions.
> > 
> > Requiring file metadata to make decisions seems reasonable. Also
> > mandatory access controls do that. The objective of this patch set is to
> > have uniform behavior regardless of the filesystem used.
> > 
> > 
> > >> This scheme relies on the ability of the kernel to not be corrupted in
> > >> the event it parses a malformed CPIO image.
> > > 
> > > I'm unaware of any buffer overruns or wild pointer traversals in the cpio
> > > extraction code. You can fill up all physical memory with initramfs and lock the
> > > system hard, though.
> > > 
> > > It still only parses them at boot time before launching PID 1, right? So you
> > > have a local physical exploit and you're trying to prevent people from working
> > > around your Xbox copy protection without a mod chip?
> > 
> > What do you mean exactly?
> > 
> > 
> > >> Mimi suggested to use
> > >> digital signatures to prevent this issue, but it cannot be used in all
> > >> scenarios, since conventional systems generate the initial ram disk
> > >> locally.
> > > 
> > > So you use a proprietary init binary you can't rebuild from source, and put it
> > > in a cpio where /dev/urandom is a file with known contents? Clearly, not
> > > exploitable at all. (And we update the initramfs.cpio but not the kernel because
> > > clearly keeping the kernel up to date is less important to security...)
> > 
> > By signing the CPIO image, the kernel wouldn't even attempt to parse it,
> > as the image would be rejected by the boot loader if the signature is
> > invalid.
> > 
> If it were signed yes, but you just said that it isn't possible to sign
> it in all cases (if initramfs is generated locally). I actually didn't
> follow that bit -- if initramfs is generated locally, and it isn't
> possible to sign locally, where would the IMA hashes for the contents of
> the initramfs come from? Is the idea that each file within the initramfs
> would be an existing, signed, file, but you could locally create an initramfs
> with some subset of those unmodified files? Even assuming this is the
> case, isn't the eventual intention to also appraise directories, to
> prevent holes where files might be moved around/deleted/renamed etc, so
> this problem would resurface anyway?
> Also eventually we need to check special nodes like device nodes etc to
> make sure they haven't been tampered with, as in Rob's urandom
> suggestion?
> > 
> > > Whatever happened to https://lwn.net/Articles/532778/ ? Modules are signed
> > > in-band in the file, but you need xattrs for some reason?
> > 
> > Appending just the signature would be possible. It won't work if you
> > have multiple metadata for the same file.
> > 
> > Also appending the signature alone won't solve the parsing issue. Still,
> > the kernel has to parse something that could be malformed.
> > 
> > Roberto
> > 
> > 
> > >> Roberto
> > > 
> > > Rob
> > > 
> > 
> > -- 
> > HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> > Managing Director: Bo PENG, Jian LI, Yanli SHI
