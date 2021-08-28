Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8783FA6E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 19:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhH1ROX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 13:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhH1ROV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 13:14:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EA5C0613D9
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Aug 2021 10:13:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z2so21525869lft.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Aug 2021 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PG8z+XIonuWGdu3czEMXRzaWItNuzacbk0dZJgvuswY=;
        b=daw0rvbIk5V4Zm8DIXbqAHGUuI91vkfb3EyX9zrL+a+hl26XvDgDL8r9dYETKE/Ae6
         NVz34RW6KNXXaquZKrMsm4y3n1D2vXOf6KLPgIF3dO3k1XtDxSAoVKVtq5UPuEzZOwXY
         C+6YEcQF+K1cqgH+D2AtQjtQx4cGEZE99d2fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PG8z+XIonuWGdu3czEMXRzaWItNuzacbk0dZJgvuswY=;
        b=RBt/87y22k1hqWbh83THoXukqxM/cZ+lz2ZT2I6hAL3v0pLqr7Iwy7wXTBS1fX/AlO
         ld+CB8dVgcKo0677NwlP99BMwk0WZKJ2xKwUwKfxTKWXT7/3E3h16UnL/NKoxiTb8oLY
         CkDqErlXrgC2/TxtDcqqqZLTjsXyLEPGEfBXT3B+vKtU+tFXH5o21i/tu1pdiJkAWphS
         qscIr6dv4i4UwaCxb6CW6B2vfUatCtOBBSySktj2LmlhIF+yYHnChbj5LEtOK7Z43WeJ
         pZCQjjMdRMmGDxWK4IrxyFDWJ7zTx6xtTkNH+1OCLqVoNqYTyD9YQA+TJUehx2CAF9lx
         Q7sg==
X-Gm-Message-State: AOAM531qxg+TBpaTlK89n+wg1rThMV2w1iL3Mt5y6GdsyBdd3OEwna+N
        M/TJGJLj9duXGL9XjmYf58eKP99TOKXwzG3Q
X-Google-Smtp-Source: ABdhPJxxQ6QMo8SHHkCZWTOmgZ+fZP3s/sOGOlE5FvXT1I37KJThvbfEhw/03QhEu92Ohz4FqGhppA==
X-Received: by 2002:a05:6512:12d4:: with SMTP id p20mr3039696lfg.304.1630170808665;
        Sat, 28 Aug 2021 10:13:28 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id u2sm1124393lji.82.2021.08.28.10.13.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 10:13:27 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id f2so17496174ljn.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Aug 2021 10:13:27 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr12752568ljc.251.1630170807239;
 Sat, 28 Aug 2021 10:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-5-agruenba@redhat.com>
 <20210827205644.lkihrypv27er5km3@kari-VirtualBox>
In-Reply-To: <20210827205644.lkihrypv27er5km3@kari-VirtualBox>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Aug 2021 10:13:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-TeAeraYo9jM7FsAVDtfCji_5ao=B3eoO10Sf2SdeTA@mail.gmail.com>
Message-ID: <CAHk-=wh-TeAeraYo9jM7FsAVDtfCji_5ao=B3eoO10Sf2SdeTA@mail.gmail.com>
Subject: Re: [PATCH v7 04/19] iov_iter: Turn iov_iter_fault_in_readable into fault_in_iov_iter_readable
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, ntfs3@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 1:56 PM Kari Argillander
<kari.argillander@gmail.com> wrote:
>
> At least this patch will break ntfs3 which is in next. It has been there
> just couple weeks so I understand. I added Konstantin and ntfs3 list so
> that we know what is going on. Can you please info if and when do we
> need rebase.

No need to rebase. It just makes it harder for me to pick one pull
over another, since it would mix the two things together.

I'll notice the semantic conflict as I do my merge build test, and
it's easy for me to fix as part of the merge - whichever one I merge
later.

It's good if both sides remind me about the issue, but these kinds of
conflicts are not a problem.

And yes, it does happen that I miss conflicts like this if I merge
while on the road and don't do my full build tests, or if it's some
architecture-specific thing or a problem that doesn't happen on my
usual allmodconfig testing.  But neither of those cases should be
present in this situation.

                    Linus
