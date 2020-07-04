Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3FB2148BA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 22:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgGDUuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 16:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgGDUuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:50:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07284C061794;
        Sat,  4 Jul 2020 13:50:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so36415477wrw.5;
        Sat, 04 Jul 2020 13:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iMabnuPWln2gm5XGf/x6VpJNWO1Ih2I1TC//Xv1HJq0=;
        b=Zz1bQ8AfAma22it+pCOtn8TK1r8ol5ZPEOyh4tsNnoLugjZ5cWoNJIYfXSDuFUKLAV
         nRgx/hMtRXG40lgmBdqzeXkmrUxJyfyKsfYrolHNKdunoqhEma5hF2UMwFzV1DFDFIku
         DXoGRifgCQrcP+mAYNQx2SWW64zCA++tWbMaqITJfjuGWhFmnpL+04fVug1q1VA76ebj
         f4k39pf3hdnqNnRDIrLp7I2Cz79N4i0QghuIMbg7MGNXSXALBkQcwv9wh4AEgB4XgBnP
         8UNRaRImq7w5u7iNyVKQlfef8bKlOuN4bbFCybqrk+DLE5PFMbIHQLBoOxSf8RsiRJQa
         Dl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iMabnuPWln2gm5XGf/x6VpJNWO1Ih2I1TC//Xv1HJq0=;
        b=YztXrjDIMMKfrpTzctnMIkji/Y9uchyLWGdybs1YHb8hsg9mIMQi4L3S9/TcyF4Iqs
         31kOhgmJQviqYAAPS59uji1h0OQbpa+PK79y15L7fQStGa4o1EYQX0UG28oh4vSRH+jf
         SlL/m+wztvCDs+eU/RdklTTQQu2OFPrc2tWDalVl5kH6WMq/DByXecYda5rwfOByae0k
         8DNfjhD5yMVp2u2skkMT9qL4G2ActaTLYIgL1zRFocv89jjv54MbiwQPHYGGSaqkDyoH
         GxTOEyxrTgAGgehyKEhbEwCHvVmfSha1pW5DuqxRkR2b7Lgr7g2F7UsP5HpDmOHXvsDd
         c5UA==
X-Gm-Message-State: AOAM533iploNPIRJnxZ/ot0h4sHbqei8CPJEox8sNpsk2Vw1C9OBAmVl
        vi75axqVZXIA9thwqyfXEA==
X-Google-Smtp-Source: ABdhPJxtHEFVZy3X5EmlLR2hKE/9VV3UALLAqm+NhckrEBx2ll0njY6FCxBpdKHtw2B/S5GdWxHyRw==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr41365286wrw.355.1593895819483;
        Sat, 04 Jul 2020 13:50:19 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.241])
        by smtp.gmail.com with ESMTPSA id b184sm18007101wmc.20.2020.07.04.13.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 13:50:18 -0700 (PDT)
Date:   Sat, 4 Jul 2020 23:50:16 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        geert@linux-m68k.org, willy@infradead.org, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] readfile: implement readfile syscall
Message-ID: <20200704205016.GA192853@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al wrote:

> > On Sat, Jul 04, 2020 at 09:41:09PM +0200, Miklos Szeredi wrote:
> >  1) just leave the first explanation (it's an open + read + close
> > equivalent) and leave out the rest
> >
> >  2) add a loop around the vfs_read() in the code.
> 
> 3) don't bother with the entire thing, until somebody manages to demonstrate
> a setup where it does make a real difference (compared to than the obvious
> sequence of syscalls, that is).

Ehh? System call overead is trivially measurable.
https://lwn.net/Articles/814175/

> At which point we'll need to figure out
> what's going on and deal with the underlying problem of that setup.

Run top?

Teach userspace to read 1 page minimum?

	192803 read(4, "cpu  3718263 4417 342808 7127674"..., 1024) = 1024
	192803 read(4, " 0 21217 21617 21954 10201 15425"..., 1024) = 1024
	192803 read(4, " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"..., 1024) = 1024
	192803 read(4, "", 1024)

Teach userspace to pread?

	192803 openat(AT_FDCWD, "/proc/uptime", O_RDONLY) = 5
	192803 lseek(5, 0, SEEK_SET)            = 0
	192803 read(5, "47198.56 713699.82\n", 8191) = 19

Rhetorical question: what is harder: ditch the main source of overhead
(VFS, seq_file, text) or teach userspace how to read files?

Here is open+read /proc/cpuinfo in python2 and python3.
Python2 case is terrifying.

BTW is there is something broken with seqfiles and record keeping?
Why does it return only 2 records per read?

Python 3:

openat(AT_FDCWD, "/proc/cpuinfo", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
ioctl(3, TCGETS, 0x7ffe6f1f0850) = -1 ENOTTY (Inappropriate ioctl for device)
lseek(3, 0, SEEK_CUR)            = 0
ioctl(3, TCGETS, 0x7ffe6f1f0710) = -1 ENOTTY (Inappropriate ioctl for device)
lseek(3, 0, SEEK_CUR)            = 0
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
read(3, "processor\t: 0\nvendor_id\t: Genuin"..., 8192) = 3038
read(3, "processor\t: 2\nvendor_id\t: Genuin"..., 5154) = 3038
read(3, "processor\t: 4\nvendor_id\t: Genuin"..., 2116) = 2116
read(3, "clmulqdq dtes64 monitor ds_cpl v"..., 8448) = 3966
read(3, "processor\t: 8\nvendor_id\t: Genuin"..., 4482) = 3038
read(3, "processor\t: 10\nvendor_id\t: Genui"..., 1444) = 1444
read(3, "t\t: 64\naddress sizes\t: 46 bits p"..., 16896) = 3116
read(3, "processor\t: 13\nvendor_id\t: Genui"..., 13780) = 3044
read(3, "processor\t: 15\nvendor_id\t: Genui"..., 10736) = 1522
read(3, "", 9214)                = 0


Python 2

openat(AT_FDCWD, "/proc/cpuinfo", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 0
lseek(3, 0, SEEK_CUR)            = 0
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
read(3, "processor\t: 0\nvendor_id\t: Genuin"..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 1024
lseek(3, 0, SEEK_CUR)            = 1024
read(3, " cqm_occup_llc cqm_mbm_total cqm"..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 2048
lseek(3, 0, SEEK_CUR)            = 2048
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 2048
lseek(3, 0, SEEK_CUR)            = 2048
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 2048
lseek(3, 0, SEEK_CUR)            = 2048
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 2048
lseek(3, 0, SEEK_CUR)            = 2048
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 2048
lseek(3, 0, SEEK_CUR)            = 2048
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 2048
lseek(3, 0, SEEK_CUR)            = 2048
read(3, "ebs bts rep_good nopl xtopology "..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 3072
lseek(3, 0, SEEK_CUR)            = 3072
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 3072
lseek(3, 0, SEEK_CUR)            = 3072
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 3072
lseek(3, 0, SEEK_CUR)            = 3072
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 3072
lseek(3, 0, SEEK_CUR)            = 3072
read(3, "ntel\ncpu family\t: 6\nmodel\t\t: 79\n"..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 4096
lseek(3, 0, SEEK_CUR)            = 4096
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 4096
lseek(3, 0, SEEK_CUR)            = 4096
read(3, "bm_local dtherm ida arat pln pts"..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 5120
lseek(3, 0, SEEK_CUR)            = 5120
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 5120
lseek(3, 0, SEEK_CUR)            = 5120
read(3, "nstop_tsc cpuid aperfmperf pni p"..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 6144
lseek(3, 0, SEEK_CUR)            = 6144
read(3, "del name\t: Intel(R) Xeon(R) CPU "..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 7168
lseek(3, 0, SEEK_CUR)            = 7168
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 7168
lseek(3, 0, SEEK_CUR)            = 7168
read(3, "d_clear flush_l1d\nvmx flags\t: vn"..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 8192
lseek(3, 0, SEEK_CUR)            = 8192
read(3, "clmulqdq dtes64 monitor ds_cpl v"..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 9216
lseek(3, 0, SEEK_CUR)            = 9216
read(3, "E5-2620 v4 @ 2.10GHz\nstepping\t: "..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 10240
lseek(3, 0, SEEK_CUR)            = 10240
read(3, "vnmi preemption_timer posted_int"..., 1024) = 1024
read(3, " vmx smx est tm2 ssse3 sdbg fma "..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 12288
lseek(3, 0, SEEK_CUR)            = 12288
read(3, ": 1\nmicrocode\t: 0xb000038\ncpu MH"..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 13312
lseek(3, 0, SEEK_CUR)            = 13312
read(3, "r invvpid ept_x_only ept_ad ept_"..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 14336
lseek(3, 0, SEEK_CUR)            = 14336
read(3, "16 xtpr pdcm pcid dca sse4_1 sse"..., 1024) = 1024
read(3, "\t\t: 1326.352\ncache size\t: 20480 "..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 16384
lseek(3, 0, SEEK_CUR)            = 16384
read(3, "gb flexpriority apicv tsc_offset"..., 1024) = 1024
read(3, "4_2 x2apic movbe popcnt tsc_dead"..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 18432
lseek(3, 0, SEEK_CUR)            = 18432
read(3, "KB\nphysical id\t: 0\nsiblings\t: 16"..., 1024) = 1024
read(3, " vtpr mtf vapic ept vpid unrestr"..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 20480
lseek(3, 0, SEEK_CUR)            = 20480
read(3, "adline_timer aes xsave avx f16c "..., 2048) = 2048
read(3, "estricted_guest vapic_reg vid pl"..., 1024) = 1024
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
lseek(3, 0, SEEK_CUR)            = 23552
lseek(3, 0, SEEK_CUR)            = 23552
read(3, "16c rdrand lahf_lm abm 3dnowpref"..., 2048) = 770
read(3, "", 1024)                = 0
close(3)                         = 0
