Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2AB125900
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 02:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfLSBA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 20:00:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41728 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSBA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 20:00:26 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so4234086ljc.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 17:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DZn9Pjgw5bCednPFYW/Dq3Fv9354h2FlZV84shXnIU=;
        b=Sf947xK3wUhl8A/UOSP4SwhxldixBoovxe4GHZek8oc9rSS3pPSToJwLOg07+ouRPY
         Gnnd/uRKTlq/qOHtpQ6qQSsHvXqv9Zu47/Ge2nIdH6ZCKkSd4H0b/pFs6kydi+1zJDWe
         MW4E5CTwi6wJsOdS4pI0C/IrpR3hNJLrV0jms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DZn9Pjgw5bCednPFYW/Dq3Fv9354h2FlZV84shXnIU=;
        b=br3+fmh5iIyxygbrSwrNB0eNWuGWt/ZFlWLN7Oa7WoBcWO3ot5kl1ntdLFape23Hpr
         edUW4d4er20HfakaLLitIhHVp6hYI1SMXXAShgoekTEtvpHILbVzpH+P8oiohzpZX39i
         eiyZxHeO98yn2EzbMKKm2l9daj4iNU7NikP+I9nlDZK42LRu0eGtcXL+MgaftPE+CKOL
         biCShVqaHwZFJz7q0GT4j2yuAyeAbON6gUR/GZVhNkFZGWY/x1saH+j5yc+Irdx0v6SL
         RA2IGEtlJGPDkXQCC5QtnYmo6oyd/a3YcD2oDjRq9biu1y3S/9A9tbUawCxJIXS7AC8n
         LJLA==
X-Gm-Message-State: APjAAAWd3SGXePlYEyLGLRZJATl+9UlVOzM5UiZEmJi6CCTpuoKws8Fc
        6EwCHwM5AOtcC+bFnI7tXTKSPg61M6w=
X-Google-Smtp-Source: APXvYqx9QQYSM7LGFOfBoBOqByN5j6AhJ5JA+VTW3S78HJTESSkUXDC2BEQ0nrtne3nYlb9aA4Tweg==
X-Received: by 2002:a2e:571d:: with SMTP id l29mr3563993ljb.193.1576717223465;
        Wed, 18 Dec 2019 17:00:23 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id i17sm124122ljd.34.2019.12.18.17.00.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 17:00:23 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id j6so4262609lja.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 17:00:23 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr3858125ljj.97.1576716909873;
 Wed, 18 Dec 2019 16:55:09 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <b2ae78da-1c29-8ef7-d0bb-376c52af37c3@yandex-team.ru> <CAHk-=wgTisLQ9k-hsQeyrT5qBS0xuQPYsueFWNT3RxbkkVmbjw@mail.gmail.com>
 <20191219000013.GB13065@localhost> <20191219001446.GA49812@localhost> <CAHk-=wgMiTbRPp6Fx_A4YV+9xL7dc2j0Dj3NTFDPRfjsjLQTWw@mail.gmail.com>
In-Reply-To: <CAHk-=wgMiTbRPp6Fx_A4YV+9xL7dc2j0Dj3NTFDPRfjsjLQTWw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Dec 2019 16:54:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjv7ntiCpdTg+fvfbP8EoxT4d9QmMp0FRtvm+cU3viCPQ@mail.gmail.com>
Message-ID: <CAHk-=wjv7ntiCpdTg+fvfbP8EoxT4d9QmMp0FRtvm+cU3viCPQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Akemi Yagi <toracat@elrepo.org>, DJ Delorie <dj@redhat.com>,
        David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 4:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This looks correct to me.

Note the "looks". I checked that it applied on current -git, and I
read through the patch, and checked that it almost matched my
original, but I didn't _test_ it in any way.  Caveat emptor.

            Linus
