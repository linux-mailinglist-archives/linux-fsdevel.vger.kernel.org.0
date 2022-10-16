Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4346002C0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Oct 2022 20:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJPSLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Oct 2022 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJPSLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:11:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BD1183BA;
        Sun, 16 Oct 2022 11:11:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w18so20397745ejq.11;
        Sun, 16 Oct 2022 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MZf9JSBULdHyGwtYSiGEH5QlAz834It5LucVZbQQMtY=;
        b=i1NppKAe+TF8yd75dMhjwNOm31MlLb+F+hAxD6OvjSBAf/A+2PtIOQhUiTp1LfQeU+
         kCHsglt+F3tjc0mtL+qCmR8LEziKGr7IgXXL0sN4TL2ON6G4D3k/vo4QB1ks8nuzruo0
         kuK2dU5f6UwGADSXe9DX7HYIh9hi7nmGL+ARj8fTAJqNguJV1CnSowd2j34COZVxO22h
         LLuebhpzQSoawoJ8pVjRbXRwkG3On60YBGa9vHL4xgfuXTDO2hJgObOZ82k+DeFfH2qi
         um+CrrHcQOYngRHNEvbuEhnythjA/wQ5OBDk1x7r0VsBM//Bx3oHKNdwnAB/CMCmEwaH
         GM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZf9JSBULdHyGwtYSiGEH5QlAz834It5LucVZbQQMtY=;
        b=2RgwRwwL5SD6biTr5S+vCwA2F5HrPShKNNzFhVCaV+NXljpU3yIaJiRap6s+R3ctRj
         DfxJ9klodlPCdNqcDUGg3ggtRhN7cv/TFKhLVnBsQtDN24wrkfqAJFaxxQGhM1/WIJ42
         VLIkKdyOOBZlcbFGJ3JqFFevuKvNnKr2sRvAOR0GUWpy9hlZkiAbVExvtAWA/JQ4NtXi
         YpcKSHspk5xovMjILyJN0e/xIHKqscgN74aeIKSJnFpcAGQjWK9VHxv7LmJAMZ5DoRtF
         LY92WOj3Tiskb0GRDBY50TOMXFL7KBjxVJEyNI63z37UKmABGHnOWSP7kHp3Hm8S+IXH
         Q36g==
X-Gm-Message-State: ACrzQf1DVgtj5BVNaKj8/pgoZ3EyNrIiU+VKbuVFPuicTugzWyBM60nH
        uO2nZMkV8h5MxLdxGN4MVsU=
X-Google-Smtp-Source: AMsMyM4zyxnWSURG70b3gbwyRkfwoySww19BUFH3STZNefgnInJDcc3lc1fSKxpKUL22rknv5zRnhg==
X-Received: by 2002:a17:907:e93:b0:78d:b8ff:9b5f with SMTP id ho19-20020a1709070e9300b0078db8ff9b5fmr6090711ejc.12.1665943894226;
        Sun, 16 Oct 2022 11:11:34 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id c22-20020a170906155600b007081282cbd8sm4854579ejd.76.2022.10.16.11.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 11:11:33 -0700 (PDT)
Date:   Sun, 16 Oct 2022 20:11:31 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v9 00/11] landlock: truncate support
Message-ID: <Y0xJUy3igQXWPAeq@nuc>
References: <20221008100935.73706-1-gnoack3000@gmail.com>
 <b8566973-63bc-441f-96b9-f822e9944127@digikod.net>
 <Y0g+TEgGGhZDm7MX@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y0g+TEgGGhZDm7MX@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 13, 2022 at 09:35:24AM -0700, Nathan Chancellor wrote:
> Hi Mickaël and Günther,
> 
> On Mon, Oct 10, 2022 at 12:35:31PM +0200, Mickaël Salaün wrote:
> > Thanks Günther! This series looks good and is now in -next with some minor
> > cosmetic comment changes.
> > 
> > Nathan, could you please confirm that this series work for you?
> 
> First of all, let me apologize for the delay in response. I am just now
> getting back online after a week long vacation, which was definitely
> poorly timed with the merge window :/
> 
> Unfortunately, with this series applied on top of commit e8bc52cb8df8
> ("Merge tag 'driver-core-6.1-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core") as
> indicated by the base commit information at the bottom of the cover
> letter, I can still reproduce the original crash I reported. What is
> even more odd is that I should be using the exact same tool versions
> that Günther is, as I am also using Arch Linux as my distribution.
> 
> I have attached the exact .config that the build system produced after
> my build, just in case there is something else in our environment that
> could be causing difficulties in reproducing.
> 
> For what it is worth, I can reproduce this in a fresh Arch Linux
> container, which should hopefully remove most environment concerns.
> 
> $ podman run \
>     --interactive \
>     --tty \
>     --rm
>     --volume .../linux-next:/linux-next \
>     --workdir /linux-next \
>     docker.io/archlinux:base-devel
> # pacman -Syyu --noconfirm \
>     aarch64-linux-gnu-gcc \
>     bc \
>     git \
>     pahole \
>     python3 \
>     qemu-system-aarch64
> ...
> 
> # aarch64-linux-gnu-gcc --version | head -1
> aarch64-linux-gnu-gcc (GCC) 12.2.0
> 
> # aarch64-linux-gnu-as --version | head -1
> GNU assembler (GNU Binutils) 2.39
> 
> # qemu-system-aarch64 --version | head -1
> QEMU emulator version 7.1.0
> 
> # git log --first-parent --oneline e8bc52cb8df8^..
> 5622ae16a601 landlock: Document Landlock's file truncation support
> 6c8a1dadeae1 samples/landlock: Extend sample tool to support LANDLOCK_ACCESS_FS_TRUNCATE
> d19c9ba61c75 selftests/landlock: Test ftruncate on FDs created by memfd_create(2)
> bf5e5018edb5 selftests/landlock: Test FD passing from restricted to unrestricted processes
> 4a7f660a22b2 selftests/landlock: Locally define __maybe_unused
> 1a9015ef7014 selftests/landlock: Test open() and ftruncate() in multiple scenarios
> 79bb219d0b7c selftests/landlock: Test file truncation support
> dd3d0e23543e landlock: Support file truncation
> dcade986e070 landlock: Document init_layer_masks() helper
> 873afb813b11 landlock: Refactor check_access_path_dual() into is_access_to_paths_allowed()
> cdda4d440c96 security: Create file_truncate hook from path_truncate hook
> e8bc52cb8df8 Merge tag 'driver-core-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> 
> # mkdir build
> 
> # mv .config build
> 
> # mv rootfs.cpio build
> 
> # make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=build Image.gz
> 
> # qemu-system-aarch64 \
>     -machine virt,gic-version=max,virtualization=true \
>     -cpu max,pauth-impdef=true \
>     -kernel build/arch/arm64/boot/Image.gz \
>     -append "console=ttyAMA0 earlycon" \
>     -display none \
>     -initrd build/rootfs.cpio \
>     -m 512m \
>     -nodefaults \
>     -no-reboot \
>     -serial mon:stdio
> ...
> [    0.000000] Linux version 6.0.0-08005-g5622ae16a601 (root@82bc572c5e5f) (aarch64-linux-gnu-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39) #1 SMP Thu Oct 13 16:30:30 UTC 2022
> ...
> [    0.491767] Trying to unpack rootfs image as initramfs...
> [    0.494156] Unable to handle kernel paging request at virtual address ffff00000851036a
> [    0.494389] Mem abort info:
> [    0.494466]   ESR = 0x0000000097c0c061
> [    0.494601]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.494756]   SET = 0, FnV = 0
> [    0.494957]   EA = 0, S1PTW = 0
> [    0.495070]   FSC = 0x21: alignment fault
> [    0.495214] Data abort info:
> [    0.495298]   Access size = 8 byte(s)
> [    0.495408]   SSE = 0, SRT = 0
> [    0.495519]   SF = 1, AR = 1
> [    0.495636]   CM = 0, WnR = 1
> [    0.495759] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041645000
> [    0.495938] [ffff00000851036a] pgd=180000005fff8003, p4d=180000005fff8003, pud=180000005fff7003, pmd=180000005ffbd003, pte=0068000048510f07
> [    0.496779] Internal error: Oops: 0000000097c0c061 [#1] SMP
> [    0.497081] Modules linked in:
> [    0.497341] CPU: 0 PID: 9 Comm: kworker/u2:0 Not tainted 6.0.0-08005-g5622ae16a601 #1
> [    0.497643] Hardware name: linux,dummy-virt (DT)
> [    0.497987] Workqueue: events_unbound async_run_entry_fn
> [    0.498635] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.498882] pc : apparmor_file_alloc_security+0x98/0x210
> [    0.499132] lr : apparmor_file_alloc_security+0x48/0x210
> [    0.499297] sp : ffff800008093960
> [    0.499403] x29: ffff800008093960 x28: ffff800008093b30 x27: ffff000002201500
> [    0.499679] x26: ffffa4c2a0e55de0 x25: ffff00000201cd05 x24: ffffa4c2a1cd0068
> [    0.499901] x23: ffff000008510362 x22: ffff000008510360 x21: 0000000000000002
> [    0.500153] x20: ffffa4c2a0f72000 x19: ffff00000201b2b0 x18: ffffffffffffffff
> [    0.500375] x17: 000000000000003f x16: ffffa4c2a15d5008 x15: 0000000000000000
> [    0.500606] x14: 0000000000000001 x13: 0000000000002578 x12: ffff00001fef1eb8
> [    0.500830] x11: ffffa4c2a15ec860 x10: 0000000000000007 x9 : ffffa4c2a0bce9ec
> [    0.501061] x8 : ffff000008510380 x7 : 0000000000000000 x6 : 0000000000001e23
> [    0.501284] x5 : ffff000008510360 x4 : ffff800008093990 x3 : ffff000002017d80
> [    0.501500] x2 : 0000000000000001 x1 : ffff00000851036a x0 : ffff00000201b2b0
> [    0.501800] Call trace:
> [    0.501957]  apparmor_file_alloc_security+0x98/0x210
> [    0.502241]  security_file_alloc+0x6c/0xf0
> [    0.502401]  __alloc_file+0x5c/0x100
> [    0.502520]  alloc_empty_file+0x68/0x110
> [    0.502630]  path_openat+0x50/0x1090
> [    0.502743]  do_filp_open+0x88/0x13c
> [    0.502858]  filp_open+0x110/0x1b0
> [    0.502961]  do_name+0xbc/0x230
> [    0.503105]  write_buffer+0x40/0x60
> [    0.503234]  unpack_to_rootfs+0x100/0x2bc
> [    0.503375]  do_populate_rootfs+0x70/0x134
> [    0.503516]  async_run_entry_fn+0x40/0x1e0
> [    0.503653]  process_one_work+0x1f4/0x460
> [    0.503783]  worker_thread+0x188/0x4e0
> [    0.503902]  kthread+0xe0/0xe4
> [    0.503999]  ret_from_fork+0x10/0x20
> [    0.504279] Code: 52800002 d2800000 d2800013 910022e1 (c89ffc20)
> [    0.504647] ---[ end trace 0000000000000000 ]---
> ...
> 
> I am not sure what else I can provide in order to reproduce this but I
> am happy to do whatever is needed to get to the bottom of this.

Thank you Nathan! I am able to reproduce this now with the .config you
provided and will have a look.

—Günther

-- 
