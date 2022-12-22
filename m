Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E78653CF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 09:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiLVIZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 03:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLVIZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:25:53 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D358175A5
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 00:25:48 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id f189so1040447vsc.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 00:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OC/60T+f/M2PU6Y7CkqM1DS3Vxgtao0z+E4uWcBqk5Y=;
        b=WMYrIQTMxAQrKOsRsdVfeWu5Ah+9BPQk/7PKprifaa3c1AfbCvp9zHc5mG15TfNQtn
         +7geSKOc/ebhm0Qc/K/1LYf9BxCaNprBhrO+G+SpSmcpLqEIywBqqWHtrFwBCwYoaGrA
         wsUMR2eEUUSNitIvb7D34YiByavlnEiTrvOxQaY9p7497UemUKKJ0eIUd9x065g2DvNU
         CO2qdFEmyw2lIoYdX+jNxL3kdph+0/J7WHxeMp01Y3iVMAcY4Eg77NhBJxrFZjNYaLle
         torpVxNcl+LhBMuC2o5O0jee1Z+yYgbbr0QfxQdJVhoUbC6l+JzTC4RHpy3uRpuebY1+
         Qu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OC/60T+f/M2PU6Y7CkqM1DS3Vxgtao0z+E4uWcBqk5Y=;
        b=OurtNJzGq+44qXUj+96CdETSI+mfen8QZin6xYdEHTY4L65ZSC8RZrI6N1FzRi0dHV
         PjlVuRGLyhauaRs9T8mzCOe1RE/NgHO/NuDWa2ohorQVRKh9yBlPwtyq4p/9UoREvSbU
         u+nC6Wxm9TR6zQvgJT1ZrcCNQz1zU5H505+IHp7IX49VDWVfDZO2xMQo9WeIKCMWN0m1
         xP8NSWGg9Oih1lkHgmYlUh5KE5pDy+Gpu1VTLmWSQAzLaOd4xHwBlYIWlmQpIvNaYdlY
         WF6oM1A6hqVqaUmUPu1q025fDR/bY0lIrCBUphkyqmLRiqT4zBn5P7TUc5ZnGwwwKpaT
         xixQ==
X-Gm-Message-State: AFqh2kqpbWJrQOsyzRgxu1oxevbpuFyKRAL0S6uo9+9b/8XEpzgok/LM
        iIeNvcs+3ZNKr7GW8IrOSF4gNOnmka6juG81FKRXpyKQJJE=
X-Google-Smtp-Source: AMrXdXtF2TiMOXBVMMHEtISxhn2z7F1l6HeFIE4j6OhBrjwUaGMAeQyusZmCUsP4O7kChTXZj/mjRWFdpVCb6cDDQPk=
X-Received: by 2002:a67:dc10:0:b0:3b3:7675:d423 with SMTP id
 x16-20020a67dc10000000b003b37675d423mr572380vsj.72.1671697547288; Thu, 22 Dec
 2022 00:25:47 -0800 (PST)
MIME-Version: 1.0
References: <CAPr0N2i3mo=SP+AdpMz=qHXejsKWs+JLTPaJVGwrzopaWOfVdA@mail.gmail.com>
In-Reply-To: <CAPr0N2i3mo=SP+AdpMz=qHXejsKWs+JLTPaJVGwrzopaWOfVdA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 22 Dec 2022 10:25:35 +0200
Message-ID: <CAOQ4uxh8c1=eBVihamhzCCAvRr38j0HCmth9ke3bo_nKsv62=A@mail.gmail.com>
Subject: Re: FIDEDUPERANGE claims to succeed for non-identical files
To:     Zbigniew Halas <zhalas@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 20, 2022 at 2:51 AM Zbigniew Halas <zhalas@gmail.com> wrote:
>
> Hi,
>
> I noticed a strange and misleading edge case in FIDEDUPERANGE ioctl.
> For the files with the following content:
> f1: abcd
> f2: efghi
> FIDEDUPERANGE claims to succeed and reports 4 bytes deduplicated,
> despite the files being clearly different. Strace output:
> openat(AT_FDCWD, "f1", O_RDONLY|O_CLOEXEC) = 3
> openat(AT_FDCWD, "f2", O_WRONLY|O_CLOEXEC) = 4
> ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=0,
> src_length=4, dest_count=1, info=[{dest_fd=4, dest_offset=0}]} =>
> {info=[{bytes_deduped=4, status=0}]}) = 0
>
> The reason is that generic_remap_checks function is doing block
> alignment of the deduplication length when the end of the destination
> file is not at the end of the deduplication range (as described in the
> comment):
> /*
> * If the user wanted us to link to the infile's EOF, round up to the
> * next block boundary for this check.
> *
> * Otherwise, make sure the count is also block-aligned, having
> * already confirmed the starting offsets' block alignment.
> */
>
> So it effectively becomes a zero-length deduplication, which succeeds.
> Despite that it's reported as a successful 4 bytes deduplication.

Ouch!

>
> For a very similar test case, but with the files of the same length:
> f3: abcd
> f4: efgh
> FIDEDUPERANGE fails with FILE_DEDUPE_RANGE_DIFFERS. Strace output:
> openat(AT_FDCWD, "f3", O_RDONLY|O_CLOEXEC) = 3
> openat(AT_FDCWD, "f4", O_WRONLY|O_CLOEXEC) = 4
> ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=0,
> src_length=4, dest_count=1, info=[{dest_fd=4, dest_offset=0}]} =>
> {info=[{bytes_deduped=0, status=1}]}) = 0
>
> For this case generic_remap_checks does not alter deduplication
> length, and deduplication fails when comparing the content of the
> files.
>

Thanks for the analysis.
Would you be interested in trying to fix the bug and writing a test?
I can help if you would like.

It's hard to follow all the changes since
54dbc1517237 ("vfs: hoist the btrfs deduplication ioctl to the vfs")
in v4.5, but it *looks* like this behavior might have been in btrfs,
before the ioctl was promoted to vfs.. not sure.

We have fstests coverage for the "good" case of same size src/dst
(generic/136), but I didn't find a test for the non-same size src/dst.

In any case, vfs_dedupe_file_range_one() and ->remap_file_range()
do not even have an interface to return the actual bytes_deduped,
so I do not see how any of the REMAP_FILE_CAN_SHORTEN cases
are valid, regardless of EOF.

What am I missing?

Thanks,
Amir.
