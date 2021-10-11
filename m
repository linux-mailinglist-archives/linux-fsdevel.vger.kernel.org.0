Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E23429A02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 01:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhJLABu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 20:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhJLABt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 20:01:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FE1C06161C
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 16:59:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r19so77511762lfe.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 16:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgVSO9l8+qaj3s+luNrigHMuS+kRVTnezRpRHPjbW94=;
        b=DKTICZkUM6+mQG0DkILdTYZfNfrDqAhQovODFervf5Lp8oEVb8SilHueb0cyn8u/xv
         XjaotArwSiIRg2V2JD0UdseT1WBdQdkROwO52I5s0Do4CGlHHCCiAQXRoQiTuYhiPvbW
         Ui91qkKHYi4ttDBdjPrMIDhbomocs37Ov8yPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgVSO9l8+qaj3s+luNrigHMuS+kRVTnezRpRHPjbW94=;
        b=YtXYXx0wqWrg+AgVR+Bb8nAwUdVOxGdhRjImWUlWGsc3F6hJ1/RlE3hX8mSylTxZKr
         Zs/vTTKVaWRSJEru5w/Wwdgz/wYMi6FHJrK6aVFSLF8piqMtMhGQpv5BOyJ27+KvSpAL
         7BbijuHw+mVN9Dm1q3f6+CQUtzgAgGFMelBsONEKP68KZsMNRT/LjM9RH2w4z3g7/Dg2
         rdI8gBv6An9HaAEMPQfGrAc6WxxgBKz2xGnMWbUfjK00oNOmLPZVxXbVU0cGYm+hifSW
         oOsvavoU/4O8bYeFCuqx5E3M8aj7Wk1nTD1z72Q0Dhb28lB0Pvq20gQky+wOqyGFRLqT
         trEw==
X-Gm-Message-State: AOAM533yTyVJISKVrxKdXwxfVu73i6sT7RCIXpgY9KwyvGbU5mr7D4mP
        bu/g9HBi1DVRLXPNY47ESnMMmX4phkKeStll
X-Google-Smtp-Source: ABdhPJwfB8v1ruTczagtNUcBGB/PcaesIVYDHAMkv1ToAXs7EOeabeQG/kxw+CXS0E/Th7uLLlF7NA==
X-Received: by 2002:a05:651c:a05:: with SMTP id k5mr5668466ljq.288.1633996786422;
        Mon, 11 Oct 2021 16:59:46 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id i12sm862318lfb.234.2021.10.11.16.59.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 16:59:44 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id j5so80271261lfg.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 16:59:44 -0700 (PDT)
X-Received: by 2002:a05:6512:139b:: with SMTP id p27mr30802647lfa.173.1633996784057;
 Mon, 11 Oct 2021 16:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk> <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk> <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk> <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk> <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com> <YWSnvq58jDsDuIik@arm.com>
In-Reply-To: <YWSnvq58jDsDuIik@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Oct 2021 16:59:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
Message-ID: <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
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

On Mon, Oct 11, 2021 at 2:08 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> +#ifdef CONFIG_ARM64_MTE
> +#define FAULT_GRANULE_SIZE     (16)
> +#define FAULT_GRANULE_MASK     (~(FAULT_GRANULE_SIZE-1))

[...]

> If this looks in the right direction, I'll do some proper patches
> tomorrow.

Looks fine to me. It's going to be quite expensive and bad for caches, though.

That said, fault_in_writable() is _supposed_ to all be for the slow
path when things go south and the normal path didn't work out, so I
think it's fine.

I do wonder how the sub-page granularity works. Is it sufficient to
just read from it? Because then a _slightly_ better option might be to
do one write per page (to catch page table writability) and then one
read per "granule" (to catch pointer coloring or cache poisoning
issues)?

That said, since this is all preparatory to us wanting to write to it
eventually anyway, maybe marking it all dirty in the caches is only
good.

                Linus
