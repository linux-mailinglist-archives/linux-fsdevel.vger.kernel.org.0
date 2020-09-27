Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C589127A10B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Sep 2020 14:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI0MqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Sep 2020 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgI0MqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Sep 2020 08:46:00 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7989C0613CE;
        Sun, 27 Sep 2020 05:45:59 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 26so8388288ois.5;
        Sun, 27 Sep 2020 05:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=2KIzto1c/T8NgUM3/QkLLI0LAX2g0ZcTIuudIF35oYs=;
        b=rQWeVuEJFHCiwZWSXWbXzKAl/nMWMRfVqIvWmy5tuBjGCpAS5BkKPSgo3neu7e+M0t
         igZ7TgiDAHEVLQifYP783DiE1vTd1Wb0ymAdnMgiWOT8RmiGTBmfS+yLc9qog7UAlGHy
         x++O2HPJhuJOml0ijn03jndN/EDWYmwuL4Oj8V1RojEe32VUJIMxQ4dAwmFytJ2i5sre
         18aLtXWBL+4m9BuauP61xbv4WF8OKFgfOVnQtYvdqqTr0K76/24gOPmZybLMd8+fYJKo
         B0fRSHz7qyuESA5E/RKGqdRAPI1pMwMysszol9uSrnwmW6XNTds2dv44kvPAY48Zg7gl
         e0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=2KIzto1c/T8NgUM3/QkLLI0LAX2g0ZcTIuudIF35oYs=;
        b=r3ckpNe2sQWCbDcPssneSk+EdE5ey7ePA/TozuPWEsnLelj3+HkezpqYZmB7FYmyza
         4fBt4g1b2QnMnz+FVOOEkPAhpjoAI3/9Xxda2wzl43BRevG8TmkFc3tH26wTbBLC1yML
         9V8gfEG80Y7Ch9mPnz0bMX1HyDu+MwwMA8K7/3vLaAxEHCU3oO/shX6yxl99trZgfW6p
         xtP4Bu1bmrcH8Bx9uPgszXs34A2C5xmVRhnIdCAox1dWcU6G6Lsp9oC+pK3SHaJA/koI
         QNC6zHyySA84ux3geA+ywBa2VkyXvCRMtzdhNSbOrcOMi6LHRsULy5uovnlvOlR/65GJ
         pO4w==
X-Gm-Message-State: AOAM530mSt7wEUYj95XfL/Mrr5vTFbUYT5032t+mZ+x8lmtAlK3QTbpE
        IT2TsRts5lN+MLXbxVJc18y4Diw3le7zEiX2ezc=
X-Google-Smtp-Source: ABdhPJzLSKNR3a3Qhmise2/SUSMkP0TlxGb7c2Y0ms5Q4GrXLlawo7zSx/kpmS5MDbMms8mMxDRtb2Hw9bCLlgfthhQ=
X-Received: by 2002:aca:ec50:: with SMTP id k77mr3478215oih.35.1601210759014;
 Sun, 27 Sep 2020 05:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org> <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org> <CA+icZUWcx5hBjU35tfY=7KXin7cA5AAY8AMKx-pjYnLCsQywGw@mail.gmail.com>
 <CA+icZUWMs5Xz5vMP370uUBCqzgjq6Aqpy+krZMNg-5JRLxaALA@mail.gmail.com>
 <20200925134608.GE32101@casper.infradead.org> <CA+icZUV9tNMbTC+=MoKp3rGmhDeO9ScW7HC+WUTCCvSMpih7DA@mail.gmail.com>
 <20200925155340.GG32101@casper.infradead.org> <CA+icZUWmF_7P7r-qmxzR7oz36u_Wy5HA6fh5zFFZd1D-aZiwkQ@mail.gmail.com>
 <20200927120435.GC7714@casper.infradead.org> <CA+icZUVoHQO7E3NNpJp2Q+fkHbvD8YmFB3xmeZnND1YDpQdw0g@mail.gmail.com>
In-Reply-To: <CA+icZUVoHQO7E3NNpJp2Q+fkHbvD8YmFB3xmeZnND1YDpQdw0g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 27 Sep 2020 14:45:47 +0200
Message-ID: <CA+icZUU_=_ct+xWfM7ddSLaSC=6CRauaLjYS-=y1u+2=G7p1jg@mail.gmail.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 27, 2020 at 2:34 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, Sep 27, 2020 at 2:04 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Sep 27, 2020 at 01:31:15PM +0200, Sedat Dilek wrote:
> > > > I would suggest that you try applying just the assertion to Linus'
> > > > kernel, then try to make it fire.  Then apply the fix and see if you
> > > > can still make the assertion fire.
> > > >
> > > > FWIW, I got it to fire with generic/095 from the xfstests test suite.
> > >
> > > With...
> > >
> > > Linux v5.9-rc6+ up to commit a1bf fa48 745a ("Merge tag 'scsi-fixes'
> > > of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi")
> > > ...and...
> > >
> > >  xfstests-dev up to commit 75bd80f900ea ("src/t_mmap_dio: do not build
> > > if !HAVE_AIO")
> > >
> > > ...I have seen in my first run of...
> > >
> > > [ generic/095 ]
> > >
> > > dileks@iniza:~/src/xfstests-dev/git$ sudo ./check generic/095
> > > FSTYP         -- ext4
> >
> > There's the first problem in your setup; you need to be checking XFS
> > to see this problem.  ext4 doesn't use iomap for buffered IO yet.
> >
> > > PLATFORM      -- Linux/x86_64 iniza 5.9.0-rc6-7-amd64-clang-cfi
> > > #7~bullseye+dileks1 SMP 2020-
> > > 09-27
> > > MKFS_OPTIONS  -- /dev/sdb1
> >
> > I'm using "-m reflink=1,rmapbt=1 -i sparse=1 -b size=1024"
> >
>
> OK, with XFS and your recommended MKFS_OPTIONS I hit it once.
>
> dileks@iniza:~/src/xfstests-dev/git$ sudo ./check generic/095
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 iniza 5.9.0-rc6-7-amd64-clang-cfi
> #7~bullseye+dileks1 SMP 2020-
> 09-27
> MKFS_OPTIONS  -- -f -m reflink=1,rmapbt=1 -i sparse=1 -b size=1024 /dev/sdb1
> MOUNT_OPTIONS -- /dev/sdb1 /mnt/scratch
>
> generic/095 19s ... [failed, exit status 1]- output mismatch (see
> /home/dileks/src/xfstests-dev/git/results//generic/095.out.bad)
>    --- tests/generic/095.out   2020-09-27 12:37:22.094208071 +0200
>    +++ /home/dileks/src/xfstests-dev/git/results//generic/095.out.bad
> 2020-09-27 14:27:53.103222500 +0200
>    @@ -1,2 +1,3 @@
>     QA output created by 095
>     Silence is golden
>    +_check_dmesg: something found in dmesg (see
> /home/dileks/src/xfstests-dev/git/results//generic/095.dmesg)
>    ...
>    (Run 'diff -u
> /home/dileks/src/xfstests-dev/git/tests/generic/095.out
> /home/dileks/src/xfstests-dev/git/results//generic/095.out.bad'  to
> see the entire diff)
> Ran: generic/095
> Failures: generic/095
> Failed 1 of 1 tests
>
> dileks@iniza:~/src/xfstests-dev/git$ diff -u
> /home/dileks/src/xfstests-dev/git/tests/generic/095.out
> /home/dileks/src/xfstests-dev/git/results//generic/095.out.bad
> --- /home/dileks/src/xfstests-dev/git/tests/generic/095.out
> 2020-09-27 12:37:22.094208071 +0200
> +++ /home/dileks/src/xfstests-dev/git/results//generic/095.out.bad
>  2020-09-27 14:27:53.103222500 +0200
> @@ -1,2 +1,3 @@
> QA output created by 095
> Silence is golden
> +_check_dmesg: something found in dmesg (see
> /home/dileks/src/xfstests-dev/git/results//generic/095.dmesg)
>
> dileks@iniza:~/src/xfstests-dev/git$ cat
> /home/dileks/src/xfstests-dev/git/results//generic/095.dmesg
> [ 2740.514321] run fstests generic/095 at 2020-09-27 14:27:34
> [ 2746.274226] XFS (sdb1): Mounting V5 Filesystem
> [ 2746.332612] XFS (sdb1): Ending clean mount
> [ 2746.337449] xfs filesystem being mounted at /mnt/scratch supports
> timestamps until 2038 (0x7fffffff)
> [ 2747.790334] ------------[ cut here ]------------
> [ 2747.790348] WARNING: CPU: 1 PID: 8678 at fs/iomap/buffered-io.c:77
> iomap_page_release+0xd7/0x130
> [ 2747.790350] Modules linked in: xfs(E) ppp_deflate(E) bsd_comp(E)
> ppp_async(E) ppp_generic(E) slhc(E) bnep(E) snd_seq_dummy(E)
> snd_hrtimer(E) snd_seq(E) snd_seq_device(E) fuse(E) intel_rapl
> _msr(E) intel_rapl_common(E) btusb(E) uvcvideo(E)
> x86_pkg_temp_thermal(E) snd_hda_codec_hdmi(E) intel_powerclamp(E)
> btrtl(E) snd_hda_codec_realtek(E) btintel(E) videobuf2_vmalloc(E)
> snd_hda_c
> odec_generic(E) videobuf2_memops(E) btbcm(E) videobuf2_v4l2(E)
> coretemp(E) bluetooth(E) videobuf2_common(E) iwldvm(E)
> ledtrig_audio(E) kvm_intel(E) mac80211(E) videodev(E) snd_hda_intel(E)
> op
> tion(E) kvm(E) zram(E) i915(E) mc(E) usb_wwan(E) msr(E)
> snd_intel_dspcfg(E) usbserial(E) cdc_ether(E) usbnet(E)
> jitterentropy_rng(E) zsmalloc(E) snd_hda_codec(E) libarc4(E) mii(E)
> irqbypass(E
> ) drbg(E) snd_hda_core(E) ghash_clmulni_intel(E) ansi_cprng(E)
> ecdh_generic(E) iwlwifi(E) ecc(E) snd_hwdep(E) aesni_intel(E)
> snd_pcm(E) cfg80211(E) libaes(E) at24(E) glue_helper(E) mei_me(E)
> snd_timer(E) crypto_simd(E) iTCO_wdt(E)
> [ 2747.790398]  samsung_laptop(E) drm_kms_helper(E) snd(E)
> intel_pmc_bxt(E) cryptd(E) mei(E) sg(E) joydev(E) cec(E) evdev(E)
> i2c_algo_bit(E) iTCO_vendor_support(E) rfkill(E) serio_raw(E) rapl
> (E) soundcore(E) intel_cstate(E) watchdog(E) intel_uncore(E) ac(E)
> pcspkr(E) button(E) binfmt_misc(E) parport_pc(E) ppdev(E) lp(E) drm(E)
> parport(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E
> ) mbcache(E) crc16(E) jbd2(E) btrfs(E) raid6_pq(E) xor(E) libcrc32c(E)
> crc32c_generic(E) sr_mod(E) cdrom(E) sd_mod(E) t10_pi(E) crc_t10dif(E)
> crct10dif_generic(E) hid_generic(E) usbhid(E) hid
> (E) uas(E) usb_storage(E) crct10dif_pclmul(E) crct10dif_common(E)
> ahci(E) libahci(E) r8169(E) xhci_pci(E) crc32_pclmul(E) ehci_pci(E)
> realtek(E) i2c_i801(E) xhci_hcd(E) ehci_hcd(E) libata(E)
> crc32c_intel(E) psmouse(E) mdio_devres(E) lpc_ich(E) i2c_smbus(E)
> scsi_mod(E) libphy(E) usbcore(E) fan(E) battery(E) wmi(E) video(E)
> [ 2747.790452] CPU: 1 PID: 8678 Comm: fio Tainted: G            E
> 5.9.0-rc6-7-amd64-clang-cfi #7~bullseye+dileks1
> [ 2747.790454] Hardware name: SAMSUNG ELECTRONICS CO., LTD.
> 530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
> [ 2747.790458] RIP: 0010:iomap_page_release+0xd7/0x130
> [ 2747.790461] Code: 29 4c 89 f7 5b 41 5e 41 5f e9 05 62 f2 ff 5b 41
> 5e 41 5f c3 0f 0b 41 83 7e 04 00 74 af 0f 0b eb ab 48 83 c2 ff 49 89
> d7 eb c4 <0f> 0b eb d3 48 83 c0 ff 48 89 c7 66 66 66
> 66 90 e9 5b ff ff ff 48
> [ 2747.790463] RSP: 0018:ffffbf4bcc5d7988 EFLAGS: 00010297
> [ 2747.790465] RAX: 0000000000000001 RBX: 0000000000000004 RCX: 0000000000000000
> [ 2747.790466] RDX: ffffe561c50018c8 RSI: 0000000000000000 RDI: ffff987c5a007ad0
> [ 2747.790468] RBP: ffff987c3817eea8 R08: ffff987c8eb54a80 R09: ffff987c8eb54a80
> [ 2747.790469] R10: 0000000000000000 R11: ffffffffc1778290 R12: ffff987c3817eea8
> [ 2747.790471] R13: 0000000000000000 R14: ffff987c5a007ac0 R15: ffffe561c5001c80
> [ 2747.790473] FS:  00007f3beb952580(0000) GS:ffff987c97a40000(0000)
> knlGS:0000000000000000
> [ 2747.790475] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2747.790477] CR2: 00007f3b9edfa168 CR3: 000000013fe04003 CR4: 00000000000606e0
> [ 2747.790478] Call Trace:
> [ 2747.790485]  iomap_releasepage+0x64/0x120
> [ 2747.790491]  invalidate_complete_page2+0x3b/0x190
> [ 2747.790494]  invalidate_inode_pages2_range+0xf3/0x460
> [ 2747.790498]  ? pagevec_lookup_range_tag+0x24/0x30
> [ 2747.790502]  ? __filemap_fdatawait_range.llvm.8376122975785580473+0xa5/0x110
> [ 2747.790505]  ? __filemap_fdatawrite_range+0x108/0x130
> [ 2747.790509]  iomap_dio_rw+0x24f/0x450
> [ 2747.790574]  xfs_file_dio_aio_write+0x227/0x340 [xfs]
> [ 2747.790619]  ? xfs_file_read_iter+0x8/0x8 [xfs]
> [ 2747.790661]  xfs_file_write_iter+0x9c/0xd0 [xfs]
> [ 2747.790666]  aio_write+0x148/0x220
> [ 2747.790670]  ? file_update_time+0x38/0x1f0
> [ 2747.790674]  ? __check_object_size+0x5a/0x1e0
> [ 2747.790676]  __io_submit_one+0x3c8/0x600
> [ 2747.790679]  ? kmem_cache_alloc+0x116/0x290
> [ 2747.790682]  io_submit_one+0x13c/0x520
> [ 2747.790686]  __do_sys_io_submit+0x8a/0x180
> [ 2747.790688]  ? __x64_sys_io_getevents+0x69/0xb0
> [ 2747.790693]  ? __ia32_sys_pipe2.cfi_jt+0x8/0x8
> [ 2747.790695]  do_syscall_64+0x53/0x90
> [ 2747.790699]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 2747.790703] RIP: 0033:0x7f3bf53d1a79
> [ 2747.790706] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
> 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e7 53
> 0c 00 f7 d8 64 89 01 48
> [ 2747.790707] RSP: 002b:00007ffc214375b8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000d1
> [ 2747.790710] RAX: ffffffffffffffda RBX: 00007f3beb950718 RCX: 00007f3bf53d1a79
> [ 2747.790711] RDX: 000055e5c234f328 RSI: 0000000000000001 RDI: 00007f3beb919000
> [ 2747.790712] RBP: 00007f3beb919000 R08: 0000000000000000 R09: 0000000000000008
> [ 2747.790714] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> [ 2747.790715] R13: 0000000000000000 R14: 000055e5c234f328 R15: 000055e5c2339a20
> [ 2747.790717] ---[ end trace b283df62bfe0869f ]---
> [ 2758.555914] XFS (sdb1): Unmounting Filesystem
>
> Again, I hit this one time.
>
> I will try to reproduce and later test with your other patch.
>

2x reproduced
total hits: 3

- Sedat -

>
> P.S.: Updated local.config with MKFS_OPTIONS recommended by willy
>
> [ local.config ]
> # Ideally define at least these 4 to match your environment
> # The first 2 are required.
> # See README for other variables which can be set.
> #
> # Note: SCRATCH_DEV >will< get overwritten!
>
> export TEST_DEV=/dev/sdc3
> ##export TEST_DEV=/dev/sdb1
> export TEST_DIR=/mnt/test
> export SCRATCH_DEV=/dev/sdb1
> ##export SCRATCH_DEV=/dev/sdc5
> export SCRATCH_MNT=/mnt/scratch
> MKFS_OPTIONS="-m reflink=1,rmapbt=1 -i sparse=1 -b size=1024"
