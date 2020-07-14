Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3996E21F635
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 17:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGNPcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 11:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgGNPcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:32:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEC0C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 08:32:41 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q7so23357374ljm.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jTmpU8Dkl5pvNFGB2BTMvHLzNVV8sfUdRQkwZjkOYc=;
        b=MNp9lKJj7EBD880it9siqaztgSYUNv2sy/wFhoNDgIzZpKe4AYAUKzWcV09V4oisxf
         HKIulcI2QBS2tkfjO7CEQSO1KsnTIWqin3TEpMbWO2sBDpv2rqyjvt2Bxz98B6d8XsYs
         XUidiZRkBG5l0bWJsyuW3RbjP6Km9DdHXUKo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jTmpU8Dkl5pvNFGB2BTMvHLzNVV8sfUdRQkwZjkOYc=;
        b=d6oOWWz7leqino1g6k7MCPsTEKVhc113HfrilWdtgaNo+5brdgtBrlX11Wb11V+3a5
         Whi54iEJyZgQaQxkPPU/GvSV8eYiq9F9ynQhTDlY3IlWM2VkcOU2tZfBAIyQeZFGHPW7
         NxIu68cbUWB8kNYSBFY9+IlQ08aKApyitmDsX0MXxwddyY3otj3OQoiQRWoxXYnBjOOZ
         MlTXKkUZ7xoLoL7sId9sKLPvuG2ofHjNCs03CZP33q93W8R8cEpqvtUYJ8ME95WBKUqt
         yAYeGklJn8XsJONaPg8TzieT4Xc8nLYSYZofo7+6SW09N+vk2sy0XWPTB8Hx5QCo2CUM
         +t3A==
X-Gm-Message-State: AOAM530l/BVu/P6e5z5H+UHbvRtGJcw46mncxJ98LWH09Sbtzpd6ozgN
        lWg90mfOXsgqM+jzIL1vZdDM+o9e2Nk=
X-Google-Smtp-Source: ABdhPJxGVuaDF5ortHxAquWeuepFDESSj9u4f00BKLh5vZyb6oa2p9o3sZgAK4B+srfzLV1m/7YT3A==
X-Received: by 2002:a2e:b8ce:: with SMTP id s14mr2459504ljp.89.1594740759994;
        Tue, 14 Jul 2020 08:32:39 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id l4sm4694638ljc.83.2020.07.14.08.32.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:32:38 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id t9so12005695lfl.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 08:32:38 -0700 (PDT)
X-Received: by 2002:ac2:5093:: with SMTP id f19mr2517777lfm.10.1594740757966;
 Tue, 14 Jul 2020 08:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
In-Reply-To: <871rle8bw2.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 08:32:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgPUov18XLYgak3zEju7pGR-XkXWi442Nq0paA5pokuQ@mail.gmail.com>
Message-ID: <CAHk-=wjgPUov18XLYgak3zEju7pGR-XkXWi442Nq0paA5pokuQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Implementing kernel_execve
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 6:30 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please let me know if you see something wrong.

Ack, looks good to me.

                 Linus
