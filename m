Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9391636CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 00:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgBRXDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 18:03:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45675 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgBRXDu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:03:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id z5so737152lfd.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2020 15:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2b+2qHSICAQfk4L4lxWTYsNq58C+5hPouycMXdDVlQ=;
        b=JCZ5z9TA9DJiwkWsOfjqukijyaYu0aIusI6XEIZJ9+uLhWezmsELqdwSOurjue6DxK
         c6QUuHorl5ixd65q+iv2YKr9OG1u4Mo/dy5UiXnuaNvNOx/7Y6I+vO1va++1CJzm9RTr
         AwzmCCvxwCjKFS8uBbdqY2NddxWSXfkklkYpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2b+2qHSICAQfk4L4lxWTYsNq58C+5hPouycMXdDVlQ=;
        b=brJejL1rtru5a7FA1T5Y4wPx5fruuO7dbDmwyxZc65J8QGAyG+Gm6hvve4xXe+nCab
         C2VRWnaseVOXFgTGBuXKRtYYN8D9mF+Vtmp6gRQyshyE6vuC2K1HwDNkwFxEgj+Weqcl
         kt95w0TT6CG6usCU+L/U/ygM8baSPn5hmc7sX105BpkjmhsTHW8ZwbQSRORjDLE9zBDn
         YqjM/snk8G8t2H+G/DEkeUFS+p/+a8H4aoa+uvVe6zwVmYgYiYayYLmAixMxYbg/NB9Z
         U/Le4mOMKi1W9Ch/DMcFXlM3KCnUF9NYzoo0Mdl/3LZtZIyL9TSDSZDvA+wwS72d4CYT
         IfuA==
X-Gm-Message-State: APjAAAV7buT7jtUDSjONu75eCMtBkm009iTSK69L3CWqiWA9lUK8rq6f
        6ifdDBUVsNJd/Mv8zejxQFcOxAxTBXY=
X-Google-Smtp-Source: APXvYqzj4Zlo26xVKmrEBriO++X+1KLmECnbKBTf0W2lCiLVqF/rc89WBxShVZ/fmI9P8vDsdRHJMg==
X-Received: by 2002:ac2:5f02:: with SMTP id 2mr11832006lfq.170.1582067026525;
        Tue, 18 Feb 2020 15:03:46 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id u16sm99870ljl.34.2020.02.18.15.03.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 15:03:45 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id x7so24929061ljc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2020 15:03:45 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr14935845ljj.265.1582067024793;
 Tue, 18 Feb 2020 15:03:44 -0800 (PST)
MIME-Version: 1.0
References: <20200214154854.6746-1-sashal@kernel.org> <20200214154854.6746-542-sashal@kernel.org>
 <CANaxB-zjYecWpjMoX6dXY3B5HtVu8+G9npRnaX2FnTvp9XucTw@mail.gmail.com>
 <CAHk-=wjd6BKXEpU0MfEaHuOEK-StRToEcYuu6NpVfR0tR5d6xw@mail.gmail.com>
 <CAHk-=wgs8E4JYVJHaRV2hMn3dxUnM8i0Kn2mA1SjzJdsbB9tXw@mail.gmail.com>
 <CAHk-=wiaDvYHBt8oyZGOp2XwJW4wNXVAchqTFuVBvASTFx_KfA@mail.gmail.com>
 <20200218182041.GB24185@bombadil.infradead.org> <CAHk-=wi8Q8xtZt1iKcqSaV1demDnyixXT+GyDZi-Lk61K3+9rw@mail.gmail.com>
 <20200218223325.GA143300@gmail.com>
In-Reply-To: <20200218223325.GA143300@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Feb 2020 15:03:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKHFB9-XggwOmBCJde3V35Mw9g+vGnt0JGjfGbSgtWhQ@mail.gmail.com>
Message-ID: <CAHk-=wgKHFB9-XggwOmBCJde3V35Mw9g+vGnt0JGjfGbSgtWhQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.5 542/542] pipe: use exclusive waits when
 reading or writing
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        stable <stable@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 2:33 PM Andrei Vagin <avagin@gmail.com> wrote:
>
> I run CRIU tests on the kernel with both these patches. Everything work
> as expected.

Thanks. I've added your tested-by and pushed out the fix.

           Linus
