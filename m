Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32617A1B99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 12:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjIOKA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 06:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjIOKAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:00:53 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD42D30D5;
        Fri, 15 Sep 2023 02:57:51 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7a5170c78e6so740792241.2;
        Fri, 15 Sep 2023 02:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771870; x=1695376670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWxJ110u032g4pSVAF7G5Jt8t0KKFay+f7qkscsfhZg=;
        b=G4Ql1XkAHjHhSZJZk0eMZklpXqlGXPlTUMZlnNqwbAcUp8RhBb3tJ93eXQovWLU+qX
         zlo/PMimNks57D6ruOZMij7YgHAq2Hz9OyKtdiYxQM/S3QaOeboJnbc+OuZMzu8Q2VHS
         tdjdjS1Gei5BnbXYJeRMXe3vzFz1NUoXbGoLnR8oM0eDGghwx8t4550IL/bFe6/VmB0P
         wjz9ptQGlUoTUTFdeDHLJceqtV/NY2kNAltoNUE2XQSgXqMhAH2nGWAXm1Wd1PJu8jDX
         2QCL84FCqYBU5Plh7zYrt7/f8yqhM2HFRr9ghKHTnwRmhGy6i3/AW8TrskdqV2BgmnZH
         ImSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771870; x=1695376670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWxJ110u032g4pSVAF7G5Jt8t0KKFay+f7qkscsfhZg=;
        b=wfuOG1L/PVzANLKpMJA2kO2TL+yA8qftGxtEP9mDSFUMpXkLQgUBgcLOkaV5LKxmQC
         hHqHhhrSA9mm2EIpTgAAp7qf+f3LUOVeI/y0u/U7VVZIyOX0UqoBBopwkpGLC5Sa9K1z
         FLp57ccfBnjccdvpcDwvQcwBJ7GkF605gJf4hniJtFGEvqvd4ixbfx7LlsfjJ/ap0DPL
         GLpHWAOhHlITKEGKRxay+sZnE3f6n2OCmfstvHKlX9QQTFcgWj+aVTfRs3Asv+pq+Eth
         hxZKRTRNzWee82xck7Y028VzZregKZXs9b/Js+rg5LDFGvY9xoJyATjMTS2eGAgvMidy
         YoDA==
X-Gm-Message-State: AOJu0YxgmdM0mGa3HHO1gticCeQzFnnibTnFKPqOdqsWZRe88ydCROQG
        BcLQrpuAda5YnMCBMVfOL0c1ub+GCXcbFvUh2ko=
X-Google-Smtp-Source: AGHT+IF025UHlK+17kZPslxbqE7SxDonSlhMRJEc1Q7wwpTO7HHa6EazXLt2X2weCNvESp4aWO5MS7Rz4bChTegau80=
X-Received: by 2002:a1f:e741:0:b0:495:f061:f2c7 with SMTP id
 e62-20020a1fe741000000b00495f061f2c7mr1154076vkh.3.1694771870190; Fri, 15 Sep
 2023 02:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230913073755.3489676-1-amir73il@gmail.com> <CAOQ4uxg2_d2eFfSy45JCCLE41qCPZtLFytnZ5x5C1uXdCMUA=Q@mail.gmail.com>
 <4919dcc1066d6952190dc224004e1f6bcba5e9df.camel@linux.ibm.com>
 <CAOQ4uxiKgYO5Z25DFG=GQj3GeGZ8unSPExM-jn1HL_U8qncrtA@mail.gmail.com> <428533f7393ab4a9f5c243b3a61ff65d27ee80be.camel@linux.ibm.com>
In-Reply-To: <428533f7393ab4a9f5c243b3a61ff65d27ee80be.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Sep 2023 12:57:39 +0300
Message-ID: <CAOQ4uxgAp_jwr-vbNn9eA9PoTrPZHuWb7+phF69c4WKmB8G4oA@mail.gmail.com>
Subject: Re: Fwd: [PATCH] ima: fix wrong dereferences of file->f_path
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[adding back fsdevel]

On Fri, Sep 15, 2023 at 7:04=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Fri, 2023-09-15 at 06:21 +0300, Amir Goldstein wrote:
> > On Thu, Sep 14, 2023 at 11:01=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > >
> > > Hi Amir,  Goldwyn,
> > >
> > > FYI,
> > > 1. ima_file_free() is called to check whether the file is in policy.
> > > 2. ima_check_last_writer() is called to determine whether or not the
> > > file hash stored as an xattr needs to be updated.
> > >
> > > 3. As ima_update_xattr() is not being called, I assume there is no
> > > appraise rule. I asked on the thread which policy rules are being use=
d
> > > and for the boot command line, but assume that they're specifying
> > > 'ima_policy=3Dtcb" on the boot command line.
> >
> > Yes, here is the kconfig from syzbot report dashboard
> > https://syzkaller.appspot.com/x/.config?x=3Ddf91a3034fe3f122
> >
> > >
> > > 4. Is commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the
> > > i_version") the problem?
> >
> > IIUC, this commit is responsible for the ovl_getattr() call in the stac=
k
> > trace. syzbot did not bisect the bug yet, but now that it has found
> > a reproducer, it is just a matter of time.
> > However, all the bug reports in the  dashboard are only from upstream,
> > so I think that means that this bug was not found on any stable kernels=
.
> >
> > >
> > > 5. ima_file_free() is being called twice.  We should not be seeing
> > > ima_get_current_hash_algo() in the trace.
> > >
> > > [   66.991195][ T5030]  ovl_getattr+0x1b1/0xf70
> > > [   66.995635][ T5030]  ? ovl_setattr+0x4e0/0x4e0
> > > [   67.000229][ T5030]  ? trace_raw_output_contention_end+0xd0/0xd0
> > > [   67.006387][ T5030]  ? rcu_is_watching+0x15/0xb0
> > > [   67.011154][ T5030]  ? rcu_is_watching+0x15/0xb0
> > > [   67.015920][ T5030]  ? trace_contention_end+0x3c/0xf0
> > > [   67.021122][ T5030]  ? __mutex_lock_common+0x42d/0x2530
> > > [   67.026506][ T5030]  ? lock_release+0xbf/0x9d0
> > > [   67.031126][ T5030]  ? read_lock_is_recursive+0x20/0x20
> > > [   67.036719][ T5030]  ? ima_file_free+0x17c/0x4b0
> > > [   67.041578][ T5030]  ? __lock_acquire+0x7f70/0x7f70
> > > [   67.046615][ T5030]  ? locks_remove_file+0x429/0x1040
> > > [   67.051820][ T5030]  ? mutex_lock_io_nested+0x60/0x60
> > > [   67.057030][ T5030]  ? _raw_spin_unlock+0x40/0x40
> > > [   67.061894][ T5030]  ? __asan_memset+0x23/0x40
> > > [   67.066577][ T5030]  ima_file_free+0x26e/0x4b0
> > > [   67.071279][ T5030]  ? ima_get_current_hash_algo+0x10/0x10
> > > [   67.076929][ T5030]  ? __rwlock_init+0x150/0x150
> > > [   67.081694][ T5030]  ? __lock_acquire+0x7f70/0x7f70
> > > [   67.086727][ T5030]  __fput+0x36a/0x910
> > > [   67.090728][ T5030]  task_work_run+0x24a/0x300
> > >
> > >
> > > Were you able to duplicate this locally?
> > >
> >
> > I did not try. Honestly, I don't know how to enable IMA.
> > Is the only thing that I need to do is set the IMA policy
> > in the kernel command line?
> >
> > Does IMA need to be enabled per fs? per sb?
> >
> > If so, I can run the overlay test suite with IMA enabled and
> > see what happens.
>
> Yes, you'll definitely will be able to see the measurement list.
>
> [Setting up the system to verify file signatures is a bit more
> difficult:  files need to be signed, keys need to be loaded.  Finally
> CentOS and RHEL 9.3 will have file signatures and will publish the IMA
> code signing key.]
>
> Assuming IMA is configured, just add "ima_policy=3Dtcb" to the command
> line.   This will measure all files executed, mmap'ed, kernel modules,
> firmware, and all files opened by root.  Normally the builtin policy is
> replaced with a finer grained one.
>
> Below are a few commands, but Ken Goldman is writing documentation -
> https://ima-doc.readthedocs.io/en/latest/
>
> 1. Display the IMA measurement list:
> # cat /sys/kernel/security/ima/ascii_runtime_measurements
> # cat /sys/kernel/security/ima/binary_runtime_measurements
>
> 2. Display the IMA policy  (or append to the policy)
> # cat /sys/kernel/security/ima/policy
>
> 3. Display number of measurements
> # cat /sys/kernel/security/ima/runtime_measurements_count
>

Nice.
This seems to work fine and nothing pops up when running
fstests unionmount tests of overlayfs over xfs.

What strikes me as strange is that there are measurements
of files in xfs and in overlayfs, but no measurements of files in tmpfs.
I suppose that is because no one can tamper with the storage
of tmpfs, but following the same logic, nobody can tamper with
the storage of overlayfs files without tampering with storage of
underlying fs (e.g. xfs), so measuring overlayfs files should not
bring any extra security to the system.

Especially, since if files are signed they are signed in the real
storage (e.g. xfs) and not in overlayfs.

So in theory, we should never ever measure files in the
"virtual" overlayfs and only measure them in the real fs.
The only problem is the the IMA hooks when executing,
mmaping, reading files from overlayfs, don't work on the real fs.

fsnotify also was not working correctly in that respect, because
fs operations on overlayfs did not always trigger fsnotify events
on the underlying real fs.

This was fixed in 6.5 by commit bc2473c90fca ("ovl: enable fsnotify
events on underlying real files") and the file_real_path() infrastructure
was added to enable this.

This is why I say, that in most likelihood, IMA hook should always use
file_real_path() and file_dentry() to perform the measurements
and record the path of the real fs when overlayfs is performing the
actual read/mmap on the real fs and IMA hooks should ideally
do nothing at all (as in tmpfs) when the operation is performed
on the "virtual" overlayfs object.

Thanks,
Amir.
