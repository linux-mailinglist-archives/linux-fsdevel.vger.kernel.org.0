Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E505F1F3F82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgFIPhK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 11:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgFIPhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:37:09 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E576C03E97C
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 08:37:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b7so1129704pju.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2020 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vTmL3j2ChselJ7CiUsiWvZhWnoud3hxCqhIar2/2kJk=;
        b=UwBjD7NDk8XLgqFoD4wx2VoBEtV/8TYGp3T3KZF72ixc/J4gQoXq3NrOWQ+nMN8SN4
         jFCfIczThOBK5LZDznABykMdxkj9H+ouW9TdQ9PngGV4Dz5C9ANuwIa3b5ce0y4K8V1H
         zxtPhIfzxeW2bjcoM2L/k6lbFiOlmpMfvBa/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vTmL3j2ChselJ7CiUsiWvZhWnoud3hxCqhIar2/2kJk=;
        b=BghMsKnkXDAuYSai2jh4mAWnkPPrWfp7WqvXF8ztMAJHE1iZVxpsNcYuzUib74bhol
         ucD6eGlB0ljGXg7SUbbFkhCseYZ3tP0eF/oHICZJZ6WpWMTxEkvVyDYF7YDyHgpzoMu0
         Be5lsjg9XWQ17L1M1vv949JTGF9g2L0gYCFDL/JQTG6lbLE0sTTLWLkerIvhefvEEvmC
         gOg+OzUu7Zqdor2fXhRLtBfNOXrEGKWCaaDQCuv/Zxdk3oBNadfjn8J3pSTx8l7bKtBz
         pFWo4g08JhN48gutSxI9w/P87wswDOfGTrnJjoGCt7c3w6syPH7SvEy5OSA9KMVZ8RfA
         FZ3w==
X-Gm-Message-State: AOAM530FcFoNw7ks/ksk9Z4uTlExu8by+cWIbPOB/ZUN8VMJPjKPSp9Z
        Uj2s+bhSO6E71rfHqib+cCvbdA==
X-Google-Smtp-Source: ABdhPJx4257lrdpLgEGz7FBr8GiLlur+c8zc+aBpEWyAeT9KGiB4Go1CWsj96UujyWTTsB++AMsmwA==
X-Received: by 2002:a17:902:c3cb:: with SMTP id j11mr4027107plj.171.1591717028787;
        Tue, 09 Jun 2020 08:37:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gt22sm3491498pjb.2.2020.06.09.08.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 08:37:07 -0700 (PDT)
Date:   Tue, 9 Jun 2020 08:37:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <202006090835.EF46A9E@keescook>
References: <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <CAHk-=wiUjZV5VmdqUOGjpNMmobGQKyZpaa=MuJ-5XM3Da86zBg@mail.gmail.com>
 <20200608162027.iyaqtnhrjtp3vos5@ast-mbp.dhcp.thefacebook.com>
 <202006081130.CE3AE614F@keescook>
 <20200609012636.5peovadjayzonqyv@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609012636.5peovadjayzonqyv@ast-mbp.dhcp.thefacebook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 06:26:36PM -0700, Alexei Starovoitov wrote:
> On Mon, Jun 08, 2020 at 11:35:12AM -0700, Kees Cook wrote:
> > On Mon, Jun 08, 2020 at 09:20:27AM -0700, Alexei Starovoitov wrote:
> > > Take android for example. It can certify vmlinux, but not boot fs image.
> > 
> > Huh? Yes it does, and for a while now. It uses Android uses dm-verity[1]
> > and fs-verity[2].
> 
> I didn't mean 'certified' like untrusted or insecure.
> I meant the vendor kernel has to satisfy and pass SDK checks to be
> certified as an android phone whereas vendor can put more or less whatever
> they like on the fs. Their own bloatware, etc.
> So for android to make sure something is part of the whole sw package
> it has to come from the kernel and its modules.
> Well, at least that's what I've been told.
> Similarly kernel upgrade doesn't necessary include boot image upgrade.
> In that sense 'elf in vmlinux' addresses packaging issue.

Well, it's much more complex than that, but I see what you mean: it's an
ELF tied to a specific kernel, like modules are. But Android's control
over modules cover such an ELF as well, if it were separate from the
kernel. Regardless, we're off in the weeds. :)

-- 
Kees Cook
