Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CED46B06C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 03:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhLGCI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 21:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhLGCI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:08:28 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A66CC0613F8
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Dec 2021 18:04:58 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f125so12314716pgc.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Dec 2021 18:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zXn+x6PjdC00rwvRf+3OxJFKpI6ggoGfZlhaFuosZ8c=;
        b=GuSxN5uVJ9+WJ2iyh1JIFGQbXut/l2v2ypgv+dneHZFLf/s3lDtFO6XiM44xUnLO1T
         lKinbTGi6CA9ot0MaE+HnJqfbGfBeISO+l2PDatV442RW/I6KMOC+W98BVX8/2h9yv+5
         RLAKzV6pJVhT52YDwnpbv1VaeTkvg7BeaZNzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zXn+x6PjdC00rwvRf+3OxJFKpI6ggoGfZlhaFuosZ8c=;
        b=YdnjnwJbHhqmhtUCvpFtlRbozLCP8F6nKj7usfY6CoCzpFz/DYA+c4vKcEqEsV6Tdc
         t2voAHipMvPNa/Oybhsdp6zR0TVrg71K+RLEjAxf50wAvF9ziOKOYmMRkusX+GZ3KqTu
         xvTescQ/bnd9yYaP+ufuvWEaxoYG3A8vm6W1amXAuRbIyDGJvPSKJydGhmjPdsCS4YEF
         FEAzBZPKQf3mdBatInW59RjGXufJDcvH0w3cIcVScoOD1BGiHahoYDozjbCnwBV3bwlz
         KrQbSftm7DK+oGCJjGeI27B9Ie5qiOaEvuW5iA6VEkE+7t1EpY99HQsb2E9/KK2pJtJs
         l91A==
X-Gm-Message-State: AOAM531UraWQyRd7q9cZaOXT/77DSoT52nNpPJuHywyPPo1LbmmPTe9m
        npnagcTxETCa21F6pR5rjm1J43PUCJeyGw==
X-Google-Smtp-Source: ABdhPJzrx4Qt1TFkMbPfKuTpvu9+Jlgy2hTOryqedenVkWnW8IAs+2d8ehAQCi7OTneU/9GiEz8pRw==
X-Received: by 2002:a63:1950:: with SMTP id 16mr22562347pgz.422.1638842697962;
        Mon, 06 Dec 2021 18:04:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y8sm14047067pfi.56.2021.12.06.18.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 18:04:57 -0800 (PST)
Date:   Mon, 6 Dec 2021 18:04:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Akira Kawata <akirakawata1@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: Unused local variable load_addr in load_elf_binary()
Message-ID: <202112061804.5185ACABD@keescook>
References: <CAKXUXMz1P8xCW+fjaiu0rvgJYmwHocMmtp+19u-+CQkLi=X2cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMz1P8xCW+fjaiu0rvgJYmwHocMmtp+19u-+CQkLi=X2cw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 06, 2021 at 04:46:01PM +0100, Lukas Bulwahn wrote:
> Dear Akira-san,
> 
> With commit 0c9333606e30 ("fs/binfmt_elf: Fix AT_PHDR for unusual ELF
> files"), you have changed load_elf_binary() in ./fs/binfmt_elf.c in a
> way such that the local variable load_addr in load_elf_binary() is not
> used anymore.

EEk! yeah, this totally broke ELF randomization. this needs to be
entirely reverted.

-- 
Kees Cook
