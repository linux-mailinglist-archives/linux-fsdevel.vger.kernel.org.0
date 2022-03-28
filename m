Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B54E9BF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 18:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241285AbiC1QKO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 12:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241279AbiC1QKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:10:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FE913DD5;
        Mon, 28 Mar 2022 09:08:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c23so15138387plo.0;
        Mon, 28 Mar 2022 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIjwzEmMu6z/tbad2d7pEHaZUw/qbqWG5HJfzLA3vFQ=;
        b=EnPhaLmFqUZJUnJj+l54pDDauT2HfeiWzNy8u38CAKVpi5hK93B/EuSzM2sYTATPVz
         T7uC19L3E+7ZLKn8269yPExjQZ17onwHAQ/21GCeDdew2fVMKHX8jTClJntWmw04Q+lm
         C3msfxx5Kria8PLsn/ri1IqgXWd+K7UM6MMwQF505N4yvDXjKzfhpFBc1vOrv4+ZvDD1
         CKEOCXrFeq6q6nfqG97d2kX5hMLrVxemN4lS875nRQ3XomEm/Pi94w+CibIc+bqsuGOF
         KhHnbWabJpzEN01OYI3yLKdD5ZP/nf5smlVO5x5CB198wuOlkgdrvDfWQW0OLNmHnZlr
         +9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIjwzEmMu6z/tbad2d7pEHaZUw/qbqWG5HJfzLA3vFQ=;
        b=vbHvg/D9S79ASQNhVGEi5//ZyEGHdgp+4RNpBz+nr2czPsjhBu0tscnSCDzHSnRVfU
         u0V5rKBy+dqN0m+K4w85uzl+uf2b/Jz4q7IP0rYHnvJVpM4YWHjNAXRYZ6Lh5WqSMxa1
         EGVpLB0cG/PX2VakeR0b8o5Vj9axULHgoRzsI8K+ybhd3wCh7e7mzCPF6gRjede1H+IQ
         Y5UY136mVe6vdByYV0YfRIXbyaonoygxGAhZJ6nLIzRbOsRQ5NuzkEdxXoAzO+pOaqmB
         jReAmIjqyU/GKrNwgco40Y7Chf40TdQqKAbPw3mHWteJ5mOj3QP0WbBJjpqkvcym2vf5
         UAHA==
X-Gm-Message-State: AOAM5310Qktp2LoBDquzIft4IBpNgjWWBKMUkB5Q374ZK/TZ5zl7m3Oj
        XFORaXhQupjqZlKwodOAFY9V/9zzTAn+Fp96A3+ggzR0eUs=
X-Google-Smtp-Source: ABdhPJwxkRuVnSEUb+UhattrKLXXZqvPQ93gcM3YiRiFd2MospQ8oVcj+eZFSvfRqA7KJaqNxfsG2jo09O+781XL8Oo=
X-Received: by 2002:a17:90b:1a8a:b0:1c7:c60b:f12 with SMTP id
 ng10-20020a17090b1a8a00b001c7c60b0f12mr25755588pjb.139.1648483709528; Mon, 28
 Mar 2022 09:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <CACA3K+i8nZRBxeTfdy7Uq5LHAsbZEHTNati7-RRybsj_4ckUyw@mail.gmail.com>
 <Yj4+IqC6FPzEOhcW@mit.edu>
In-Reply-To: <Yj4+IqC6FPzEOhcW@mit.edu>
From:   Fariya F <fariya.fatima03@gmail.com>
Date:   Mon, 28 Mar 2022 21:38:18 +0530
Message-ID: <CACA3K+hAnJESkkm9q6wHQLHRkML_8D1pMKquqqW7gfLH_QpXng@mail.gmail.com>
Subject: Re: df returns incorrect size of partition due to huge overhead block
 count in ext4 partition
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

Thanks for the response. Really appreciate it. Some questions:

a) This issue is observed on one of the customer board and hence a fix
is a must for us or at least I will need to do a work-around so other
customer boards do not face this issue. As I mentioned my script
relies on df -h output of used percentage. In the case of the board
reporting 16Z of used space and size, the available space is somehow
reported correctly. Should my script rely on available space and not
on the used space% output of df. Will that be a reliable work-around?
Do you see any issue in using the partition from then or some where
down the line the overhead blocks number would create a problem and my
partition would end up misbehaving or any sort of data loss could
occur? Data loss would be a concern for us. Please guide.

//* More info on my script: I have a script which monitors the used
percentage of the partition using df -h command and when the used
percentage is greater than 70%, it deletes files until the used
percentage comes down. Considering df
is reporting all the time 100% usage, all my files get deleted.*//

b) Any other suggestions of a work-around so even if the overhead
blocks reports more blocks than actual blocks on the partition, i am
able to use the partition reliably or do you think it would be a
better suggestion to wait for the fix in e2fsprogs?

I think apart from the fix in e2fsprogs tool, a kernel fix is also
required, wherein it performs check that the overhead blocks should
not be greater than the actual blocks on the partition.

Regards

On Sat, Mar 26, 2022 at 3:41 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Mar 25, 2022 at 12:12:30PM +0530, Fariya F wrote:
> > The output dumpe2fs returns the following
> >
> >     Block count:              102400
> >     Reserved block count:     5120
> >     Overhead blocks:          50343939
>
> Yeah, that value is obviously wrong; I'm not sure how it got
> corrupted, but that's the cause of the your problem.
>
> > a) Where does overhead blocks get set?
>
> The kernel can calculate the overhead value, but it can be slow for
> very large file systems.  For that reason, it is cached in the
> superblock.  So if the s_overhead_clusters is zero, the kernel will
> calculate the overhead value, and then update the superblock.
>
> In newer versions of e2fsprogs, mkfs.ext4 / mke2fs will write the
> overhead value into the superblock.
>
> > b) Why is this value huge for my partition and how to correct it
> > considering fsck is also not correcting this
>
> The simpleest way is to run the following command with the file system
> unmounted:
>
> debugfs -w -R "set_super_value overhead_clusters 0" /dev/sdXX
>
> Then the next time you mount the file system, the correct value should
> get caluclated and filled in.
>
> It's a bug that fsck isn't notcing the problem and correcting it.
> I'll work on getting that fixed in a future version of e2fsprogs.
>
> My apologies for the inconvenience.
>
> Cheers,
>
>                                         - Ted
