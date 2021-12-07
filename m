Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968CF46B179
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 04:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhLGD1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 22:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbhLGD1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:27:20 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1087CC061746;
        Mon,  6 Dec 2021 19:23:51 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id l64so6887395pgl.9;
        Mon, 06 Dec 2021 19:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jh/Kjz0Ns9vTlq2xsujkefYFH6sZw0GJ2m8+AGu9qfQ=;
        b=JXKUeqDKv01CWYnopMmmIVsbT8tqxwhoRS082UHG6irEZG/NqiWz5O6E5dQ3spdbuh
         abZr6fDeQyo7ArFzx6ZcofBcjJwXohJtQSL6V8CPYyLSVJb7ZKFgdyjZdAwDy2+vX5hR
         ynhvuK63LlHuNAE+TrPmlbJsYnDL3Ci24lomtvQN9V0fDr1zd7Sh7w2NXs8mqfE2nApI
         HE+rpKgrxCauN1iEkumLCAd4Sooph8qjSWdQythnM7rTFrD0ifTdFF4g8ZU2dMdcFhN2
         iRL5G1+zfeeff1OZmKMBJEwhBNjvE+k+Fm/0MxX/MZndPLIaMbAKXn3QbJWZwYMXF7Aj
         MJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jh/Kjz0Ns9vTlq2xsujkefYFH6sZw0GJ2m8+AGu9qfQ=;
        b=mPnE1U3H/fPVS1zLMPsQfr1jJ5S5htDwzpdvZvo+l9nHLljrKlndKHIi3fknwyHJRR
         8bxnq/dg5U2DYYs2RGaEM4uH4aZhlQIro2ZZ36NLKvse+n6QovJD6TeJVE7VY/hUEc/6
         ajj0RVI5Kaqj5Y8px53tSmEVHUZcvYsEOfwMcbfNchoUlzQWLA3GiHC8xRsrsxd+2k1X
         SNQepzY8XySjzz1rDdvgJbZzG/yJYk8QRFEXAmXbUMkdfSpSxcA6lLmLOFRs3wpXEbD1
         KFivggAcTcrDFocXYi5v13iPWqUmMneSsV7AdZIF15orAO9Del4gM8B6gXA10YAguTVN
         TD0A==
X-Gm-Message-State: AOAM533lcoWhJCt2Ob1Bt6CBVViYADG3tUpHmXQk+klcn4pNIgNRbXO4
        araw19GBxTa49/iRSAYb5bA=
X-Google-Smtp-Source: ABdhPJyHQizBCf7Ert+hGTJt2QADRILWK71efUXgoNCe91XR6d7BUKs/8X+g5kidC4fkpxqw+AY1sQ==
X-Received: by 2002:a63:1446:: with SMTP id 6mr21669961pgu.150.1638847430496;
        Mon, 06 Dec 2021 19:23:50 -0800 (PST)
Received: from gmail.com ([2400:2410:93a3:bc00:c35d:e29e:99a3:5fd9])
        by smtp.gmail.com with ESMTPSA id s14sm13939343pfk.73.2021.12.06.19.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 19:23:50 -0800 (PST)
Date:   Tue, 7 Dec 2021 12:23:46 +0900
From:   Akira Kawata <akirakawata1@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: Unused local variable load_addr in load_elf_binary()
Message-ID: <20211207032346.g47nf4n6374xyaw2@gmail.com>
References: <CAKXUXMz1P8xCW+fjaiu0rvgJYmwHocMmtp+19u-+CQkLi=X2cw@mail.gmail.com>
 <202112061804.5185ACABD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112061804.5185ACABD@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 06, 2021 at 06:04:56PM -0800, Kees Cook wrote:
> On Mon, Dec 06, 2021 at 04:46:01PM +0100, Lukas Bulwahn wrote:
> > Dear Akira-san,
> > 
> > With commit 0c9333606e30 ("fs/binfmt_elf: Fix AT_PHDR for unusual ELF
> > files"), you have changed load_elf_binary() in ./fs/binfmt_elf.c in a
> > way such that the local variable load_addr in load_elf_binary() is not
> > used anymore.
> 
> EEk! yeah, this totally broke ELF randomization. this needs to be
> entirely reverted.
> 
> -- 
> Kees Cook

I think my patch doesn't affect on ELF randomization because it keeps
the way of load_addr calculation.


Akira Kawata
