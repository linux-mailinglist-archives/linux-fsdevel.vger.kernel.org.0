Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85715579869
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 13:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbiGSL0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 07:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbiGSL0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:26:53 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F83A3DBEF
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 04:26:51 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10c0052da61so31187507fac.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=020GL0O0hflXIxVwmtfRiD+2r8usxk+LpcYhr4gv+S8=;
        b=jTC6FmREwwRm6mWYH7G34+k++tluRwbkr8cS0HSWRGwVLzTj+m4tF48rD3YjRQr3+L
         gtQ7k1PWASf2VskYTcp9cMIrGDV/Rn1Br+cFrmDn6WpQaxOYKGirm6oDYmQ1HbrGEUXG
         W+ZW/je304Bx1ohhsGP0TgQquEH5m5vDnA6Q/FaHnWvLpp8YcHPK7aD2W37sBKT40JV2
         0kMXTdElzVdfKGd/ut+q/eDzqjq+mPt01qdKu+m/j2RHRzjdB/lcwvw2kG+JYZLLpi9Y
         whdPBeRqdkgP6b4vauNBo1eCvEpSy036spvRs6EPK+66TAg1gjDmfNO9viCGyQAofFJg
         x1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=020GL0O0hflXIxVwmtfRiD+2r8usxk+LpcYhr4gv+S8=;
        b=UO+VyM5M4N0Q/0IbekNGUq6uDme865912C4/Mrx+WoUCBb/RJ+AZjLrCMy1/mmMyo6
         wZ7bxXQ0Ba7NYzKAgqUxqYojO7NY4ADZ9Rahav4HbYrv8x3qyJL3X+Qo/c0i4Z2vG6Hu
         Pie03QjDFL+ZiRYfm10svYOQu7wM3zfnZxNMTLpoxefJ2LvTpHzoqv6HrPbp3dZVwRGL
         5MT/ZhZhxE8cB4lUHjY/MSjWFj1X9aFY7O4NWWfxmTaz3tNZkoKWlkeVj6mdGSYqpMtj
         coz8jiSoUGfa9sglYEdEHj4V/C088wrm29IC+xQ3O5iyHOWkGcs5tpPF3hUNf3SUNL+G
         kDWw==
X-Gm-Message-State: AJIora9KaIQ2A8OgDNcvVNsRuD8typy33Elvyc5qwubdDujwnj0RbXyd
        nUOdAjFFj29AyrEhnIDpViqVeg==
X-Google-Smtp-Source: AGRyM1tk8HI8+1ViLbB6aMm2aE0/A4gRLdN+YTFW9qiCQewVFUO0cN0LIZLYNEfPELYIwGnDIdRbsA==
X-Received: by 2002:a05:6871:890:b0:10b:f3eb:b45d with SMTP id r16-20020a056871089000b0010bf3ebb45dmr18169031oaq.294.1658230010898;
        Tue, 19 Jul 2022 04:26:50 -0700 (PDT)
Received: from [192.168.86.210] ([136.62.38.22])
        by smtp.gmail.com with ESMTPSA id cb1-20020a056830618100b00616c46f6daasm6116229otb.31.2022.07.19.04.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 04:26:50 -0700 (PDT)
Message-ID: <14f9274e-87bd-9202-59c0-7f2ca836144d@landley.net>
Date:   Tue, 19 Jul 2022 06:33:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
Content-Language: en-US
To:     Jim Baxter <jim_baxter@mentor.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bug-cpio@gnu.org" <bug-cpio@gnu.org>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        "takondra@cisco.com" <takondra@cisco.com>,
        "kamensky@cisco.com" <kamensky@cisco.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "james.w.mcmechan@gmail.com" <james.w.mcmechan@gmail.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
References: <33cfb804-6a17-39f0-92b7-01d54e9c452d@huawei.com>
 <1561909199.3985.33.camel@linux.ibm.com>
 <45164486-782f-a442-e442-6f56f9299c66@huawei.com>
 <1561991485.4067.14.camel@linux.ibm.com>
 <f85ed711-f583-51cd-34e2-80018a592280@huawei.com>
 <0c17bf9e-9b0b-b067-cf18-24516315b682@huawei.com>
 <20220609102627.GA3922@lxhi-065>
 <21b3aeab20554a30b9796b82cc58e55b@huawei.com>
 <20220610153336.GA8881@lxhi-065>
 <4bc349a59e4042f7831b1190914851fe@huawei.com>
 <20220615092712.GA4068@lxhi-065>
 <032ade35-6eb8-d698-ac44-aa45d46752dd@mentor.com>
 <f82d4961986547b28b6de066219ad08b@huawei.com>
 <737ddf72-05f4-a47e-c901-fec5b1dfa7a6@mentor.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <737ddf72-05f4-a47e-c901-fec5b1dfa7a6@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/18/22 13:08, Jim Baxter wrote:
> 
> 
> Best regards,
> 
> *Jim Baxter*
> 
> Siemens Digital Industries Software
> Automotive Business Unit
> DI SW STS ABU
> UK
> Tel.: +44 (161) 926-1656
> mailto:jim.baxter@siemens.com <mailto:jim.baxter@siemens.com>
> sw.siemens.com <https://sw.siemens.com/>
> 
> On 18/07/2022 17:49, Roberto Sassu wrote:
>>> From: Jim Baxter [mailto:jim_baxter@mentor.com]
>>> Sent: Monday, July 18, 2022 6:36 PM
>>>
>>>
>>> Hello,
>>>
>>> I have been testing these patches and do not see the xattr information when
>>> trying to retrieve it within the initramfs, do you have an example of how
>>> you tested this originally?
>> 
>> Hi Jim, all
>> 
>> apologies, I didn't find yet the time to look at this.
> 
> Hello Roberto,
> 
> Thank you for your response, I can wait until you have looked at the patches,
> I asked the question to make sure it was not something wrong in my
> configuration.
> 
>> 
>> Uhm, I guess this could be solved with:
>> 
>> https://github.com/openeuler-mirror/kernel/commit/18a502f7e3b1de7b9ba0c70896ce08ee13d052da
>> 
>> and adding initramtmpfs to the kernel command line. You are
>> probably using ramfs, which does not have xattr support.
>> 
> 
> 
> Thank you, I have tested that patch but the problem remained. Here is my
> command line, I wonder if there is something wrong.
> 
> Kernel command line: rw rootfstype=initramtmpfs root=/dev/ram0 initrd=0x500000000 rootwait 

/dev/ram0 is a block device. Trying to provide it to tmpfs is like trying to say:

  mount -t proc /dev/sda1 /proc

There's nowhere for the block device to GO because it's not a block backed
filesystem.

There's four types of filesystem: block back, pipe backed, ram backed, and
synthetic.

- Only block backed filesystems take a block device argument. Block backed
filesystems require two drivers: one to handle I/O to the block device and one
to interpret the filesystem format with the block device. You do not "format"
any other kind of filesystem. (There's no mkfs.nfs or mkfs.proc: it doesn't work
that way.)

- Pipe backed ones include network filesystems (nfs, samba), FUSE filesystems,
or hybrid weirdness like https://wiki.qemu.org/Documentation/9psetup . These
drivers talk a protocol over a pipe (or network socket, or char device, or...)
to a server at the far end that serves up the filesystem contents. Usually their
source argument is a server address plus filesystem identification plus login
credentials. Often they have a wrapper program that assembles this argument for you.

- Ram backed filesystems (ramfs, tmpfs) treat the "source" argument to mount(2)
as basically a comment, and ignore it. When you're adding things like size
limitations, it goes in the "data" argument (I.E. mount -o thingy).

- synthetic filesystems are just interfaces to the kernel that make up their
contents programmatically (proc, sys, cgroup...) and no two are alike, although
they generally ignore their "source" argument and look at "data" too.

I wrote up documention about this many years ago...

  https://landley.net/toybox/doc/mount.html

> I also found that root is always mounted as rootfs in my initramfs system
> which I understood to be tmpfs, is that incorrect?

Yes, although the kernel tries to hide this by lying in /proc/mounts for bad
reasons.
> I modified the file before packing. To pack I use the following commands:
> 
> $ ./usr/gen_initramfs.sh -l initramfs.list -e xattr ../rootfs > initramfs.cpio
> $ gzip initramfs.cpio
> $ mkimage -A arm64 -O linux -T ramdisk -d initramfs.cpio.gz uRamdisk
> 
> The kernel is loaded using:
> booti ${kernaddr} ${initramaddr} ${dtbaddr}

Remove the root= argument from your kernel command line. It is explicitly
telling the kernel "we will not be staying in rootfs" and thus it doesn't use
tmpfs for it. In your case, you're saying "we're going to overmount the initial
ramfs with a ram disk block device", which is nonsensical because nothing can
have populated it so it will be all zeroes (unformatted) and thus the filesystem
type detection staircase in
https://github.com/torvalds/linux/blob/v5.18/init/do_mounts_rd.c#L38 won't be
able to find a filesystem type to mount on it and it's guaranteed to fail.

Note: initramfs was introduced in the early 2000s, and back in the 1990s there
was an older "initrd" mechanism that DID use ramdisks (which are a chunk of ram
used as a block device). I wrote documention about THAT too:

  https://www.kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt

Basically the mechanism you're feeding init.cpio.gz in through was originally
written to populate a ramdisk, and you'd make an ext2 image or something and
gzip that. These days, the kernel decompresses the first few bytes of the file
and if the result is a cpio signature it calls the initramfs plumbing
(extracting the archive into the ram backed filesystem) and if not it extracts
it into the /dev/ram0 block device and treats it as an initial ram disk. In
NEITHER case do you need root= because that's used AFTER initramfs and initrd
have both failed to find an /init program. (Well initrd looks for /linuxrc
instead of /init because historical cruft, and then there was pivot_root...
Don't go there.)

Rob
