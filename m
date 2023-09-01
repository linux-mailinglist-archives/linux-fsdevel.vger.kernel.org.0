Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6005C78FBCC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 12:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348930AbjIAKhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 06:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjIAKhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:37:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EED10CE
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Sep 2023 03:37:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso2250292a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Sep 2023 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693564622; x=1694169422; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1ZtOmmUyUHsJfv4kZ2SxuGxZMcXZ7XGWuYUry0oDA0=;
        b=uLOy3sYvM3XHwk8z4+ItlFe7gPB3ene2rd+FiMUDMponwPMNQwPvjw+aep3DbhPAEz
         wguipI0aCL33kOEUsdln4Cu5Txw4B2vjeEdrl9P2QAXP+9WIhVaAUIponlmv4VOrhe03
         KnstwsImzaAqFlIkXBHcdVEEgZU13NjpR6uIsmYlCfn7dyXOqHKRnjKXYou+Ac/pTT4o
         ttm2nwmFz04YsarpvnW8pEWntMkRuVu8lFT1ZZ9Jc7icNmRUoYhJc12hH6xci4dzL6oe
         x2rTHAH+JcGMvHuO6AFZragMK+UoK5MQ41W8v9bCNzJLe3DrlWp8W1ZOCTI9PNIJ8yY/
         lICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693564622; x=1694169422;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H1ZtOmmUyUHsJfv4kZ2SxuGxZMcXZ7XGWuYUry0oDA0=;
        b=YDrMiFRja6JePbFiBr8yhhFnF/sSvCRgZncRz9mMbjyYjq1sFdzUjkQPkOqKFTZWiW
         AvcpJ5iWp2weTgfRGUeDNVIbhOXyFcGUlghNbv1zzP5FQm6QliMDt8+xKWgU00vtK42D
         0cjZT0us8UKRx8EWNgrcWMXdkA9bEx5wiz7RXDcavaBavxWU/VpgKNpQU9dSZH8UUlCv
         5kIdawNZCul41lBAUTw+8MmMef7LJRz//DXyMvhTc6CtMlUO8z2lMDwyUpVxXML9UBII
         GoVGlYvOZKcls68CI47SqbhBFy+5d4jAbH1+YjTR5URiLiMHsNAPLf1Rq7bilOLBA/mp
         bMEg==
X-Gm-Message-State: AOJu0YwmTCkiSWt0ZqtKJ/kOZg5+N7aKODXpdZTKav9aHfbPgDkuUyQX
        ZjvEYVu3XNF3GjlIbVtCVt3wbQ==
X-Google-Smtp-Source: AGHT+IFNlKnN7dJb+GuNlMKWA12egaLKprzsWCbsoyPebkYoiY/dym9gVNq/qV7dap3/RFa/GJqhKA==
X-Received: by 2002:aa7:ccc2:0:b0:522:57d9:6553 with SMTP id y2-20020aa7ccc2000000b0052257d96553mr1706209edt.1.1693564622005;
        Fri, 01 Sep 2023 03:37:02 -0700 (PDT)
Received: from localhost (i53878940.versanet.de. [83.135.137.64])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c2c7000000b00523a43f9b1dsm1904700edp.22.2023.09.01.03.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 03:37:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 01 Sep 2023 12:37:00 +0200
Message-Id: <CV7IJY36ZXDZ.250Z3B8VKN4Y5@ablu-work>
Subject: Re: [BUG] virtio-fs: Corruption when running binaries from
 virtiofsd-backed fs
Cc:     "Vivek Goyal" <vgoyal@redhat.com>,
        "Stefan Hajnoczi" <stefanha@redhat.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Manos Pitsidianakis" <manos.pitsidianakis@linaro.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        <linux-kernel@vger.kernel.org>
To:     "Erik Schilling" <erik.schilling@linaro.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <virtio-fs@redhat.com>
From:   "Erik Schilling" <erik.schilling@linaro.org>
X-Mailer: aerc 0.15.2
References: <CV5Q388ZKSI3.2N5DT3BRV3RIM@fedora>
In-Reply-To: <CV5Q388ZKSI3.2N5DT3BRV3RIM@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed Aug 30, 2023 at 10:20 AM CEST, Erik Schilling wrote:
> Hi all!
>
> Some days ago I posted to #virtiofs:matrix.org, describing that I am
> observing what looks like a corruption when executing programs from a
> virtiofs-based filesystem.
>
> Over the last few days I spent more time drilling into the problem.
> This is an attempt at summarizing my findings in order to see what other
> people think about this.
>
> When running binaries mounted from virtiofs they may either: fail with a
> segfault, fail with badaddr, get stuck or - sometimes - succeed.
>
> Environment:
>   Host: Fedora 38 running 6.4.11-200.fc38.x86_64
>   Guest: Yocto-based image: 6.4.9-yocto-standard, aarch64
>   virtiofsd: latest main + some debug prints [1]
>   QEMU: built from recent git [2]
>
> virtiofsd invocation:
>   RUST_LOG=3D"debug" ./virtiofsd --seccomp=3Dnone --sandbox=3Dnone \
>     --socket-path "fs.sock0" --shared-dir $PWD/share-dir/ --cache=3Dnever
>
> QEMU invocation:
>   ~/projects/qemu/build/qemu-system-aarch64 -kernel Image -machine virt \
>     -cpu cortex-a57 \
>     -serial mon:stdio \
>     -device virtio-net-pci,netdev=3Dnet0 \
>     -netdev user,id=3Dnet0,hostfwd=3Dtcp::2223-:22 \
>     -display none -m 2048 -smp 4 \
>     -object memory-backend-memfd,id=3Dmem,size=3D2048M,share=3Don \
>     -numa node,memdev=3Dmem \
>     -hda trs-overlay-guest.qcow2 \
>     -chardev socket,id=3Dchar0,path=3D"fs.sock0" \
>     -device vhost-user-fs-pci,queue-size=3D1024,chardev=3Dchar0,tag=3D/de=
v/root \
>     -append 'root=3D/dev/vda2 ro log_buf_len=3D8M'
>
> I figured that launching virtiofsd with --cache=3Dalways masks the
> problem. Therefore, I set --cache=3Dnever, but I think I observed no
> difference compared to the default setting (auto).
>
> Adding logging to virtiofsd and kernel _feeled_ like it made the problem
> harder to reproduce - leaving me with the impression that some race is
> happening on somewhere.
>
> Trying to rule out that virtiofsd is returning corrupted data, I added
> some logging and hashsum calculation hacks to it [1]. The hashes check
> out across multiple accesses and the order and kind of queued messages
> is exactly the same in both the error case and crash case. fio was also
> unable to find any errors with a naive job description [3].
>
> Next, I tried to capture info on the guest side. This became a bit
> tricky since the crashes became pretty rare once I followed a fixed
> pattern of starting log capture, running perf and trying to reproduce
> the problem. Ultimately, I had the most consistent results with
> immediately running a program twice:
>
>   /mnt/ld-linux-aarch64.so.1 /mnt/ls.coreutils /; \
>     /mnt/ld-linux-aarch64.so.1 /mnt/ls.coreutils /
>
>   (/mnt being the virtiofs mount)
>
> For collecting logs, I made a hack to the guest kernel in order to dump
> the page content after receiving the virtiofs responses [4]. Reproducing
> the problem with this, leaves me with logs that seem to suggest that
> virtiofsd is returning identical content, but the guest kernel seems to
> receive differing pages:
>
> good-kernel [5]:
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x312 nodeid=
 0x1 in.len 56 out.len 104
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 1 unique 0x314 nodeid=
 0x1 in.len 53 out.len 128
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x316 nodeid=
 0x29 in.len 56 out.len 104
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 14 unique 0x318 nodei=
d 0x29 in.len 48 out.len 16
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 15 unique 0x31a nodei=
d 0x29 in.len 80 out.len 832
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs: page: 000000006996d520
>   kernel: virtio_fs: to: 00000000de590c14
>   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
................
>   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
................
>   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
................
>   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
................
>   [...]
>
> bad-kernel [6]:
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x162 nodeid=
 0x1 in.len 56 out.len 104
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 1 unique 0x164 nodeid=
 0x1 in.len 53 out.len 128
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 3 unique 0x166 nodeid=
 0x16 in.len 56 out.len 104
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 14 unique 0x168 nodei=
d 0x16 in.len 48 out.len 16
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs_wake_pending_and_unlock: opcode 15 unique 0x16a nodei=
d 0x16 in.len 80 out.len 832
>   kernel: virtiofs virtio1: virtio_fs_vq_done requests.0
>   kernel: virtio_fs: page: 000000006ce9a559
>   kernel: virtio_fs: to: 000000007ae8b946
>   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
................
>   kernel: virtio_fs rsp:00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  =
................
>   kernel: virtio_fs rsp:80 40 de c8 ff ff 00 00 cc 2b 62 ae ff ff 00 00  =
.@.......+b.....
>   kernel: virtio_fs rsp:02 4e de c8 ff ff 00 00 00 00 00 00 00 00 00 00  =
.N..............
>   [...]
>
> When looking at the corresponding output from virtiofsd, it claims to
> have returned identical data:
>
> good-virtiofsd [7]:
>   [DEBUG virtiofsd::server] Received request: opcode=3DRead (15), inode=
=3D41, unique=3D794, pid=3D481
>   [src/server.rs:618] r.read_obj().map_err(Error::DecodeMessage)? =3D Rea=
dIn {
>       fh: 31,
>       offset: 0,
>       size: 832,
>       read_flags: 2,
>       lock_owner: 6838554705639967244,
>       flags: 131072,
>       padding: 0,
>   }
>   [src/file_traits.rs:161] hash =3D 2308490450751364994
>   [DEBUG virtiofsd::server] Replying OK, header: OutHeader { len: 848, er=
ror: 0, unique: 794 }
>
> bad-virtiofsd [8]:
>   [DEBUG virtiofsd::server] Received request: opcode=3DRead (15), inode=
=3D22, unique=3D362, pid=3D406
>   [src/server.rs:618] r.read_obj().map_err(Error::DecodeMessage)? =3D Rea=
dIn {
>       fh: 12,
>       offset: 0,
>       size: 832,
>       read_flags: 2,
>       lock_owner: 6181120926258395554,
>       flags: 131072,
>       padding: 0,
>   }
>   [src/file_traits.rs:161] hash =3D 2308490450751364994
>   [DEBUG virtiofsd::server] Replying OK, header: OutHeader { len: 848, er=
ror: 0, unique: 362 }
>
> The "corruption" only seems to happen in this one page, all other pages
> are identical between runs (except that the bad run terminates earlier).
>
> What do the experts think here? To me it feels a bit like some kind of
> corruption is going on. Or am I misinterpreting things here?
>
> Which further analysis steps would you suggest?
>
>
> Further notes:
>
> After collecting the above results, I realized that running the guest
> with -smp 1 makes the problems a lot worse. So maybe that is a better
> choice when trying to reproduce it.
>
> Repo with my scripts is available at:
> https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-conf=
ig/
>
> The scripts are just quick and dirty implementations and are not
> particulary portable.

Summary of my testing during the last few days:

Testing with KCSAN revealed a few cases that look like missing READ_ONCE
annotations (will send patches separately). But nothing of that was
related to the immediate problem. I tested instrument_read() and another
round of logging with a delay to virtio_fs_request_complete. It looks
like the buffer get corrupted before entering that function. KCSAN
or manual sleeps + prints did not show any corruption while in that
function.

KASAN did not report any issues.

Patching virtiofsd to do an additional copy and going through rust-vmm's
.copy_to() function did not change the behaviour.

I will mostly be off next week, will continue analysis afterwards. Happy
to hear about suggestions of other things to try :).

Good weekend,

- Erik


>
> - Erik
>
> [1] https://gitlab.com/ablu/virtiofsd/-/commit/18fd0c1849e15bc55fbdd6e1f1=
69801b2b03da1f
> [2] https://gitlab.com/qemu-project/qemu/-/commit/50e7a40af372ee5931c99ef=
7390f5d3d6fbf6ec4
> [3] https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-=
config/-/blob/397a6310dea35973025e3d61f46090bf0c092762/share-dir/write-and-=
verify-mmap.fio
> [4] https://github.com/Ablu/linux/commit/3880b9f8affb01aeabb0a04fe76ad770=
1dc0bb95
> [5] Line 12923: https://git.codelinaro.org/erik_schilling/jira-orko-65-bo=
otstrap-k3s-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/goo=
d-drop-bad-1.txt
> [6] Line 12923: https://git.codelinaro.org/erik_schilling/jira-orko-65-bo=
otstrap-k3s-config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/goo=
d-bad-1.txt
> [7] https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-=
config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/virtiofsd.txt#L=
2538-2549
> [8] https://git.codelinaro.org/erik_schilling/jira-orko-65-bootstrap-k3s-=
config/-/blob/main/logs/2023-08-29%2013%3A42%3A35%2B02%3A00/virtiofsd.txt#L=
1052-1063

