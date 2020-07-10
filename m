Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BFA21B15C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 10:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGJIaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 04:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgGJIa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:30:29 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F632C08C5CE;
        Fri, 10 Jul 2020 01:30:29 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s9so5471122ljm.11;
        Fri, 10 Jul 2020 01:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mDEWF/gOHqnVFbtfXXs3ljAiSAYlhLzutQWngIQGuuA=;
        b=gOS7slEjmfSIMc70Zc4XyrJRIJM2oHl+hs03QvhWxULpvqVJRwvk+8TrRA6a3vCwqD
         DbzkKYHptOiixHhYHah4akFTFUzgKK/cjSeM0PDbl3yQ0KZ8xjvt5Wagm6mb27m/v/EG
         rRsnTdmxRbeG3kpNoeF5b53oEJpXDhJpUZJQmTOOYLx5Pk4GrnIQoKiIhX3PoWDndD6c
         y4M/J5bldXsB6uD2BkNgJgZun2FiluzeNRLyg7D+M2yWbCpy99AenMdqyoyrJnq+E7lg
         nKMc4FfS4GhtjeJBDu8QQ2KBB9v0eh6uGLktxEBwjwka6RawpQ/YKimwwvqRM0zzs8DT
         bWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mDEWF/gOHqnVFbtfXXs3ljAiSAYlhLzutQWngIQGuuA=;
        b=HV7MOc2LziQ80Cf72csrRckMsZHGDJHzPTVfbkkyZARlPV74/huXnj1slDuXfovuD5
         +3LkBOittJT5qWRO4JyAJA/lZg7QJXHk3xbmv///GM94oiBOIFqEOMdF8B6cawtHwk4d
         W2J3iILB4Hgar+kG2lAho+2S7YyarmCIEcnMArWzCw+cGQuacPz4v7mGAYqrOA/YroMb
         BDR5Mbj2BhwJuY5cIN1LEKNjDtMd8TDIJ1TuOi4IclppOD7BQdynsQngLLAOFCnaeE9X
         vBesNX2HYf69DjrQBREj9q7TxsBscISoBGulmd7Q7qIY2UT1j0rPVeuSFtM48YGZeBnJ
         aFDw==
X-Gm-Message-State: AOAM530cju8szFpK7DFzyVSSUI1LgWFOBTm1tAzpi9y3LpnQVJyRTQpN
        s6YSH3eyl2w6M5HTgk2CnVtzyYwW
X-Google-Smtp-Source: ABdhPJyUbobhnRfuG8Q1eZvawPHgCwKO9ruGuN4OGU+5ociRzwSU/5mMHtbE8iYfIW16kZia9aABLg==
X-Received: by 2002:a2e:9e89:: with SMTP id f9mr4747347ljk.212.1594369827440;
        Fri, 10 Jul 2020 01:30:27 -0700 (PDT)
Received: from grain.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id 2sm1900072lfr.48.2020.07.10.01.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 01:30:26 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id E95A91A007B; Fri, 10 Jul 2020 11:30:25 +0300 (MSK)
Date:   Fri, 10 Jul 2020 11:30:25 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcmp: add separate Kconfig symbol for kcmp syscall
Message-ID: <20200710083025.GD1999@grain>
References: <20200710075632.14661-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710075632.14661-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 10, 2020 at 09:56:31AM +0200, Rasmus Villemoes wrote:
> The ability to check open file descriptions for equality (without
> resorting to unreliable fstat() and fcntl(F_GETFL) comparisons) can be
> useful outside of the checkpoint/restore use case - for example,
> systemd uses kcmp() to deduplicate the per-service file descriptor
> store.
> 
> Make it possible to have the kcmp() syscall without the full
> CONFIG_CHECKPOINT_RESTORE.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> I deliberately drop the ifdef in the eventpoll.h header rather than
> replace with KCMP_SYSCALL; it's harmless to declare a function that
> isn't defined anywhere.

Could you please point why setting #fidef KCMP_SYSCALL in eventpoll.h
is not suitable? Still the overall idea is fine for me, thanks!

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
