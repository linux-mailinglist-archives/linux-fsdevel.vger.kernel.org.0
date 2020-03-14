Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64945185429
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 04:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgCNDMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 23:12:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42015 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgCNDMx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 23:12:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so6122016pgs.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 20:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a4vxLIWWizY4c94tKl8VxzoeCXjGcvdAGAK/KKBIiws=;
        b=W6ezz92Fnc3Q/6TEc9BYLSA6xe+WA9hEJXfgEQZIyFIsHVOW2NBbH5DPiqAJcu5JuP
         89pFOrYQQjN250fN/yIJqbyrY/PL2EEyLT0eNefPLUNFyPanFZWHpCahR/d0OOLoVWkK
         KJRWch1vHZa9uSzMPyR92lWlIsKeosUfl0jqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a4vxLIWWizY4c94tKl8VxzoeCXjGcvdAGAK/KKBIiws=;
        b=CgflS36c6XdCe0pLAxLT6W3VE8aqwrdzgAAioqWIdxCogFFYBmiIN9Ss3QVYvAxzTA
         t2F1nRW1bGjkYtoSpcPc3QCVUjqqPoMy93XXvCtwDtYxS6oRJVDB+qnwvALaoQ8WVdGP
         lJbRHuQkB4NRcg3fS7Wiqc7Ujp/B8KiyUE46zx8IfI9k5t+oWW5XAVuPMuF9ViIanikp
         a3pHlC85ADG9YI6+kSrxnDMzymkgBVa7dUww1Tmy47ZAJFj2UJjLyUeS44WWdAYvy605
         OfW2uPs3c3x6UXQqBHwvBhYy0CPdQoe9QegekodaDywBVtGXQft9DwhgU/608FMFytun
         2KUg==
X-Gm-Message-State: ANhLgQ0x8jsUoyBOPFkVFksZpQGlRQpYos2VHPxS8YNRcle0o/MMW6k2
        W93U0cJIbFSEvXX/TR6yvnpz4Q==
X-Google-Smtp-Source: ADFU+vs4x5cG7qYmSSdMh7Lt9j4AbCiuf8O4X5jvNemXHgiKvZMzloMDqnCWSAI9GJ6X1EWvJR70AA==
X-Received: by 2002:a63:3193:: with SMTP id x141mr16084059pgx.311.1584155572098;
        Fri, 13 Mar 2020 20:12:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k3sm2188966pgr.40.2020.03.13.20.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 20:12:51 -0700 (PDT)
Date:   Fri, 13 Mar 2020 20:12:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org, yzaikin@google.com,
        tglx@linutronix.de, kernel@gpiccoli.net
Subject: Re: [PATCH] kernel/hung_task.c: Introduce sysctl to print all traces
 when a hung task is detected
Message-ID: <202003132011.8143A71FE@keescook>
References: <20200310155650.17968-1-gpiccoli@canonical.com>
 <ef3b3e9a-9d58-60ec-d638-88ad57d29aec@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef3b3e9a-9d58-60ec-d638-88ad57d29aec@canonical.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 02:23:37PM -0300, Guilherme G. Piccoli wrote:
> Kees / Testsuo, are you OK with this patch once I resend with the
> suggestions you gave me?

I think so, yes. Send a v2 (to akpm with us in CC).

> Is there anybody else I should loop in the patch that should take a
> look? Never sent sysctl stuff before, sorry if I forgot somebody heheh

akpm usually takes these kinds of things.

-- 
Kees Cook
