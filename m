Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A85C116003
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 01:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLHA6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 19:58:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33829 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLHA6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 19:58:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id m6so11682968ljc.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Dec 2019 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjInLVbNXJAcoeCkZ2UVa8n0Yvnc+/klAZS5TAwHv4s=;
        b=h6ddV75ipxBKXFOA9CDG/DsvE2JTK3HbVomfQE6untuDafGb0uM3UTD+kBuTeURAJr
         YaLxU9OJ6BU0yKYe4O/Q1IYMqIaS6oyUAb7OTpsABdji+FCn80FeRKA9nWv9YeQerxr2
         Ixb3YlsXil8s4tHITSEfWE+Fn1dKsFgLFg/0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjInLVbNXJAcoeCkZ2UVa8n0Yvnc+/klAZS5TAwHv4s=;
        b=cUwVYAZPTIYEdAXPHNvnWz4gCngHgsGQ1VK543I94QiRDK2XYosAHTzhTpgFGGoIEZ
         W7Q05lSEcRDII8hmr1TK3xnc1CACxiAcn3Bt1a9M/uG/WnwYgcavjhbSQO1vK9CmZRHP
         dWB3gsj75fS3Sc9pR8tFewmS1k8Wv/VomlRE96xSD/uxoD31pMlT0sM4YwGey48ZNY6H
         CCAnsnnCW3lIeHLWLYh2mf7AskiltetrHOa9BbAf4xVsyF18w/EtRZaPcTqDd95BW+ki
         URN5hfXwWiq+9xDPlHF3tBS9kqMQN0WWLKrxXacYpKajIndaK+/nnjsyFFNo34uk97cl
         xuMQ==
X-Gm-Message-State: APjAAAXXQl1VwlLD2pjdFCfg3NfHtz3VZc0l+dkLdGNmmLxYlZgK9XYL
        loeB35Mc9QtgZfVDKzTT45dwxbut8XA=
X-Google-Smtp-Source: APXvYqwhbZyCK/m3JDGJtOZR4/CUz7AmndtI9Ia3uUEsLZu1gwWBSb/iOFjPuza8SPJaQ9autBxHSw==
X-Received: by 2002:a2e:880a:: with SMTP id x10mr12615288ljh.211.1575766688853;
        Sat, 07 Dec 2019 16:58:08 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id a9sm8669787lfj.83.2019.12.07.16.58.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 16:58:07 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id e28so11619420ljo.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Dec 2019 16:58:07 -0800 (PST)
X-Received: by 2002:a2e:241a:: with SMTP id k26mr12682848ljk.26.1575766687450;
 Sat, 07 Dec 2019 16:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20191207171402.GA24017@fieldses.org> <20191207171832.GB24017@fieldses.org>
In-Reply-To: <20191207171832.GB24017@fieldses.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Dec 2019 16:57:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgiQO7PCgQ5YKbJ86TLEs8G_M6k2OtFBY5m2AcNOCcJ0g@mail.gmail.com>
Message-ID: <CAHk-=wgiQO7PCgQ5YKbJ86TLEs8G_M6k2OtFBY5m2AcNOCcJ0g@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd change for 5.5
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 7, 2019 at 9:18 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Oh, also, not included: server-to-server copy offload.  I think it's
> more or less ready, but due to some miscommunication (at least partly my
> fault), I didn't get them in my nfsd-next branch till this week.  And
> the client side (which it builds on) isn't merged yet last I checked.
> So, it seemed more prudent to back them out and wait till next time.

The cline side part should have just got merged (Trond and you both
waited until the end of the merge window for your pull requests), but
it's just as well to have the server side be done next release..

               Linus
