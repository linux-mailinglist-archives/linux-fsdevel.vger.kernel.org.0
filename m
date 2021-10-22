Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42268437002
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 04:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhJVCdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 22:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbhJVCdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:33:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF5BC061764
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 19:30:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so544225lfu.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 19:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbgzVLDCT8DipeBdsMkDowoxxylwz2da/ifUpbOh8z0=;
        b=aYdcT/n7CqiA/S03OD1v/gZ0kFeK1PDL0lbPxqn104neWrT3qjy5Y6eL+8vHQrxt+h
         oDvWfNFAoUdvOICh0XHKZOWmwBJf6fUUWWLjSlhQrvjMiomhUTFGWClWL1HzZ9q2WL4O
         1ego9HzyYIvaXZ0i0rLIDMjdtPo9LTw/DYSYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbgzVLDCT8DipeBdsMkDowoxxylwz2da/ifUpbOh8z0=;
        b=7PAwoNr4eV8+2dti40xE1gDAyNArkRBsrnGLrcrkWYw5gZKKgE+jiW9zBiCze6Ud3m
         cxkVa8Nlzc4RRx0InZStnwXt63Jq3CUdBivmNyyTI4t3cX0lfFSve9Ds2J/jGbARvxVn
         v9FS+48WkeNFq5tPi92R2sNPJFU0GRufKnAkKQJSK1Ugm7SqL4pgvdsjsS9K+4WPlB/J
         8cugOQBRfi1m9Ecjuv1SDv7w/g1kltRAXenPvb2WJX10xC/tbOrUaqI+ELIWKlXwXXLG
         GoxVsinmRfiPuWKJrerAI4YZB8BgquBuxNzgAF7N83Gz5++vdiC2jVjgYTXe9qtUzFDe
         UxKA==
X-Gm-Message-State: AOAM533xl58uDt6AE0kjFJnPYoKtkrrOGQImbVZTfUE01aNgc1d6FN4E
        GiqKKpREcJSuQGMpk/ooj8nGP+gEsQp7IA==
X-Google-Smtp-Source: ABdhPJx7TH7uB+DcDxRWNPggthNEROtx7rQv463UPxqAgbgB8TMpEcLWDVt5Fxn3PxXMll4/D4gLNA==
X-Received: by 2002:a05:6512:c0a:: with SMTP id z10mr9071581lfu.664.1634869848724;
        Thu, 21 Oct 2021 19:30:48 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r17sm599471lfe.107.2021.10.21.19.30.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 19:30:47 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 145so3309914ljj.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 19:30:47 -0700 (PDT)
X-Received: by 2002:a2e:a407:: with SMTP id p7mr10376944ljn.68.1634869846779;
 Thu, 21 Oct 2021 19:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk> <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk> <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk> <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
 <YWSnvq58jDsDuIik@arm.com> <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
 <CAHc6FU7bpjAxP+4dfE-C0pzzQJN1p=C2j3vyXwUwf7fF9JF72w@mail.gmail.com>
 <YXE7fhDkqJbfDk6e@arm.com> <CAHc6FU5xTMOxuiEDyc9VO_V98=bvoDc-0OFi4jsGPgWJWjRJWQ@mail.gmail.com>
In-Reply-To: <CAHc6FU5xTMOxuiEDyc9VO_V98=bvoDc-0OFi4jsGPgWJWjRJWQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Oct 2021 16:30:30 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgvnU2PXFMpsNErdwE=tXGymLHe275jWkBhCbGiixWU5g@mail.gmail.com>
Message-ID: <CAHk-=wgvnU2PXFMpsNErdwE=tXGymLHe275jWkBhCbGiixWU5g@mail.gmail.com>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 4:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> But probing the entire memory range in fault domain granularity in the
> page fault-in functions still doesn't actually make sense. Those
> functions really only need to guarantee that we'll be able to make
> progress eventually. From that point of view, it should be enough to
> probe the first byte of the requested memory range

That's probably fine.

Although it should be more than one byte - "copy_from_user()" might do
word-at-a-time optimizations, so you could have an infinite loop of

 (a) copy_from_user() fails because the chunk it tried to get failed partly

 (b) fault_in() probing succeeds, because the beginning part is fine

so I agree that the fault-in code doesn't need to do the whole area,
but it needs to at least do some <N bytes, up to length> thing, to
handle the situation where the copy_to/from_user requires more than a
single byte.

                 Linus
