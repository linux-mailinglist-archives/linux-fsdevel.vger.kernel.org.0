Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75192B4EE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 19:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgKPSJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 13:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730628AbgKPSJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 13:09:49 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A0C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 10:09:48 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id e139so6953715lfd.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 10:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hu5++/kJeVjJEiUxVlOBfldGtXXjOObK0j9yLP+sNSY=;
        b=baew2OznxixMFWwa8rFtZDjYndGY/BNHPjeYN+gAEWyL0FCL+lP2R5/6+0IMTekE1b
         99wN8eBTB1s9tBaULqn1FTc9kugWtNBBn5NM7/2LqHdal6yjEeyuRb3cbNiHh8OnolhC
         Fji9oRMYFO1DUSacVg94h0YAeOGP8+oDGNNXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hu5++/kJeVjJEiUxVlOBfldGtXXjOObK0j9yLP+sNSY=;
        b=kOavYzCy+XeQLvQVJWbZ0VodD8oCeG+xPbs/5ruIjZzomordpaJgLYYo8TA5qBqkvD
         0bTq6WPPOqc5ex8QUBECixFrxUVYVmCfAobyIrjwDQRB9QKIEtdRw07AD/YjMK0IRmb6
         zu+jl3u4B8SFZ2E3mLtboGBmMcN7LyYaa/YLjYT2kFoQtXm8PtLKBTCevUPmOczYvkIb
         oIuAqZ3IeebRGyfx2K1EasiuaqUn3la9aCJYtfomiPk9SPrTIsjwd+tBI5vw5oC5JSDJ
         TvGIcPL2A55yt6SY+4FBBwq83jpvWYKReDF2/NK6oY8r+UcJ2/zEuPOtX8dLBXirLkhS
         SkqQ==
X-Gm-Message-State: AOAM533vzzNSOfYwGSwxdtWzqnMdFhlaySSRbUeQd3lqDQN+drrIMD5y
        yHG4ppGxU62SB+5Vm8E6LgrLhWSbYJMnAw==
X-Google-Smtp-Source: ABdhPJwnC5zdXoOqTb1wiQep3ain1lSlr//Xcy4ZkJBSC9NSLOpu7c2eZqhAu+4WslOTVSVluQOWfw==
X-Received: by 2002:a05:6512:3286:: with SMTP id p6mr193423lfe.383.1605550186610;
        Mon, 16 Nov 2020 10:09:46 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id b8sm2776357ljo.68.2020.11.16.10.09.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 10:09:45 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id y16so21215330ljh.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 10:09:45 -0800 (PST)
X-Received: by 2002:a2e:3503:: with SMTP id z3mr240954ljz.70.1605550184840;
 Mon, 16 Nov 2020 10:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
 <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com> <20201116174127.GA4578@infradead.org>
In-Reply-To: <20201116174127.GA4578@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Nov 2020 10:09:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjd0RNthZQTLVsnK_d9SFYH0rug2tkezLLB0J-YZzVC+Q@mail.gmail.com>
Message-ID: <CAHk-=wjd0RNthZQTLVsnK_d9SFYH0rug2tkezLLB0J-YZzVC+Q@mail.gmail.com>
Subject: Re: [RESEND][PATCH] ima: Set and clear FMODE_CAN_READ in ima_calc_file_hash()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 9:41 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> The "issue" with IMA is that it uses security hooks to hook into the
> VFS and then wants to read every file that gets opened on a real file
> system to "measure" the contents vs a hash stashed away somewhere.

Well, but that's easy enough to handle: if the open isn't a read open,
then the old contents don't matter, so you shouldn't bother to measure
the file.

So this literally sounds like a "doctor, doctor, it hurts when I hit
my head with a hammer" situation..

         Linus
