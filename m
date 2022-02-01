Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D004A648B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 20:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242017AbiBATDY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 14:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240803AbiBATDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:03:23 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E00C061714
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Feb 2022 11:03:23 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a28so35815622lfl.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Feb 2022 11:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCbdSgGi68nDz/yve/bgX706hkshLjqkzBpzirTtK9w=;
        b=MW124t1ty/PYVAfbe0OIa6o8AMt7xGPQIsZZzlRt4hpIprOWPju7hLciOPYhTNQMOa
         Y+VDTi9VyjLfREYI5M97fsVW1HHR9wMcXAjgUJ8o0uNZfZGKRpAS6/BHfxCneaHgqrdS
         GCAcRBcqCQHjOJ8HpZTyGwXj3J8G7anBJcepOBQeVC/pAU5X2rEAZlM6sOL2Ukp6u5y4
         FGBW5s8R1rEqOuuqtSTGPxILigghO5WtQosS1wS/TjazRF9rhmUDrKUKPfCQ2+gjLP+k
         gw1TOiBssrztSf0izbpMs9GI3I79UEK/jM2mZ0XW7Kfy09qEW/D8xH30NSQJsPOL5LY7
         icug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCbdSgGi68nDz/yve/bgX706hkshLjqkzBpzirTtK9w=;
        b=Yejfl5XCwRMipvqVHx/b//mpKyzMEejF1LpqBIc2K1h/CtgsCdg3GtRANUUljDaco8
         KaSNWfc5UfRqzGt0rnaUBG38w/jb5K9WQuE0XuKDqg0uFun/2njVXjZjrl2o2iT8jjw2
         yuAKeQ/VtYxultEyEIkuictrYFOH6jn/7rGd5tsZVnA8HAS/Px2K6gpiTTeFCJltvtsl
         6176ZGNvb1SIScECCBiapgEVxG+a4mB1bb3iMc2At6HU5Cb2bVPKHYNpnCPoTs2oWCoq
         Elw3i8Cw5PxwUfjSsxnMq/LJjp7v6nhoPj1+a4xU4ebEC/sQp+v+PsNz5ORPs3DQL2Hs
         Bckg==
X-Gm-Message-State: AOAM533uhnkYIQucCIxuBRSZEgmQbC+eKkErgJTn78Y2ydo9ufvVr8xc
        cB8HfkjdLXiSEIV4mxxTmk+oMYEj+02hTnyeGEF6Ng==
X-Google-Smtp-Source: ABdhPJySu9ztXRn884TXwSJLBO6N5cPj7d5jaLn6+jX40z+AkgZ34ljS32dL/oRqbl4fjUcRCHnHPVaTGbIQua0Wt/8=
X-Received: by 2002:a05:6512:441:: with SMTP id y1mr19860532lfk.315.1643742201155;
 Tue, 01 Feb 2022 11:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20220131153740.2396974-1-willy@infradead.org> <871r0nriy4.fsf@email.froward.int.ebiederm.org>
 <YfgKw5z2uswzMVRQ@casper.infradead.org> <877dafq3bw.fsf@email.froward.int.ebiederm.org>
 <YfgPwPvopO1aqcVC@casper.infradead.org> <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
 <87bkzroica.fsf_-_@email.froward.int.ebiederm.org> <87iltzn3nd.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87iltzn3nd.fsf_-_@email.froward.int.ebiederm.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 1 Feb 2022 20:02:54 +0100
Message-ID: <CAG48ez3zfi1eHAgGPPEC=pB3oMUBif28Ns4qncUbxpCbMPYdgA@mail.gmail.com>
Subject: Re: [PATCH 5/5] coredump: Use the vma snapshot in fill_files_note
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 7:47 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Matthew Wilcox reported that there is a missing mmap_lock in
> file_files_note that could possibly lead to a user after free.
>
> Solve this by using the existing vma snapshot for consistency
> and to avoid the need to take the mmap_lock anywhere in the
> coredump code except for dump_vma_snapshot.
>
> Update the dump_vma_snapshot to capture vm_pgoff and vm_file
> that are neeeded by fill_files_note.
>
> Add free_vma_snapshot to free the captured values of vm_file.
>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Link: https://lkml.kernel.org/r/20220131153740.2396974-1-willy@infradead.org
> Cc: stable@vger.kernel.org
> Fixes: a07279c9a8cd ("binfmt_elf, binfmt_elf_fdpic: use a VMA list snapshot")
> Fixes: 2aa362c49c31 ("coredump: extend core dump note section to contain file names of mapped files")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
[...]
> +static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm)
>  {
>         struct mm_struct *mm = current->mm;
> -       struct vm_area_struct *vma;
>         unsigned count, size, names_ofs, remaining, n;
>         user_long_t *data;
>         user_long_t *start_end_ofs;
>         char *name_base, *name_curpos;
> +       int i;
>
>         /* *Estimated* file count and total data size needed */
>         count = mm->map_count;

This function is still looking at mm->map_count in two spots, please
change those spots to also look at cprm->vma_count. In particular the
second one looks like it can cause memory corruption if the map_count
changed since we created the snapshot.

[...]
> +static void free_vma_snapshot(struct coredump_params *cprm)
> +{
> +       if (cprm->vma_meta) {
> +               int i;
> +               for (i = 0; i < cprm->vma_count; i++) {
> +                       struct file *file = cprm->vma_meta[i].file;
> +                       if (file)
> +                               fput(file);
> +               }
> +               kvfree(cprm->vma_meta);
> +               cprm->vma_meta = NULL;

(this NULL write is superfluous, but it also doesn't hurt)

> +       }
> +}
