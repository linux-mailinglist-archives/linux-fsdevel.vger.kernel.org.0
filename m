Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A3246AEC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 01:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378051AbhLGAFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 19:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378046AbhLGAFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:05:25 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9EDC0613F8;
        Mon,  6 Dec 2021 16:01:56 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id l64so6456598pgl.9;
        Mon, 06 Dec 2021 16:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TRVmR5B5GtMOM5DOCEErKiwBMO/09svpKKnKlbJkOiw=;
        b=NtWC+ksGIBpRu4LYc5RB7KSpPhZL1WPg57XSOdPOkSKqUUjhli2QK6Dk7ZvR7AHP0n
         +TrcIWH/IAKRH7UnbCMunVZEtTvGphQulwoL+1/QJSoqJ4IQnhZcqnPrsHc+dKUh1XaF
         XwwATXjEHiIqgTbxK+oJCTGPO0V6yB2zDMPIZ93UTV8lG4Dsp9K+SB/VlFkibtsJNIo1
         jjS7saZw6uWLvi1Eg4qhDRoV9v0zMt3vEEUcca/Zq93fCZBh7qQy7YdTQIwhA9ssiWyA
         zxK4xMmYhJ/Xagl8rW2/aba2FzQKq3FxwmWcXQsXnZXtemYUDI46xZL/J9KmqjvRdX+O
         +jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TRVmR5B5GtMOM5DOCEErKiwBMO/09svpKKnKlbJkOiw=;
        b=WHglQWfVmho4AkxEcEh29C6iTymptPDZHFn1Bti9BsT8BMKuNOnJq07dnN9JL1EYQ0
         QuKGLvY4HHrx+vZgBnBtI043Wq50yy4uCeIsPzKu0Y1Vh+BqjEqElWlRmTwH+M6ARJIF
         pk9lMG2X7b/lGHcsthMiT02RvqRMZ5z0Lvb35Yzm3MSmrWyxif4LvplC/hA1284vNkNe
         046YAaXtykspbMvwzEJpQPojmRXwHZxU/kL8/Hld/D8PRT82CXzhkWQicv8//zoJ+V/T
         KyjoB6+DzCZH1T8iR6FJZafm6ZFy87HxzgLsndAZOPFPOmcYof+KApNkc6AC+nqMTuRc
         TT1Q==
X-Gm-Message-State: AOAM530VReo+Jc9DkORIERbQAhr9e7adbrougnLzMXamflK9bEzkFIfd
        siHKwGskWZl3GWA8BCyca1Q=
X-Google-Smtp-Source: ABdhPJzEMQE31rRjYktSVEoq74oZyT7HrROxUkyDOH+IMUZb8SiYY7jGOfCNX9XVgiNzbJ6q14DF1w==
X-Received: by 2002:a63:110d:: with SMTP id g13mr851759pgl.315.1638835315651;
        Mon, 06 Dec 2021 16:01:55 -0800 (PST)
Received: from gmail.com ([2400:2410:93a3:bc00:c35d:e29e:99a3:5fd9])
        by smtp.gmail.com with ESMTPSA id h1sm4425203pfh.219.2021.12.06.16.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 16:01:55 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:01:50 +0900
From:   Akira Kawata <akirakawata1@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: Unused local variable load_addr in load_elf_binary()
Message-ID: <20211207000150.whruf5uuzbxl274y@gmail.com>
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
> 
> I had a quick look at the code and I think the following refactoring
> would be good:
> 
> 1. Remove the definition of load_addr and its unneeded computation of load_addr
> 
> 2. Rename load_addr_set to first (or a similar name) to represent that
> this variable is not linked to the non-existing load_addr, but states
> that it captures the first iteration of the loop. Note that first has
> the inverse meaning of load_addr_set.
> 
> The issue was reported by make clang-analyzer:
> 
> ./fs/binfmt_elf.c:1167:5: warning: Value stored to 'load_addr' is
> never read [clang-analyzer-deadcode.DeadStores]
>                                 load_addr += load_bias;
>                                 ^            ~~~~~~~~~
> 
> 
> Best regards,
> 
> Lukas

Thank you for your comments. Should I send a new patch, or change
the existing patch in linux-next?

Akira
