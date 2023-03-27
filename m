Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6BC6CAF83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 22:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjC0UNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 16:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjC0UNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:13:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751891FDC;
        Mon, 27 Mar 2023 13:13:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id le6so9555233plb.12;
        Mon, 27 Mar 2023 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679948010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omEl4yPfArYML/MdFjW82OoYkdDQuGLeGfrwdlfaKrg=;
        b=QGjjwRzZJt5yGnesyULsZv/7aHlvCOSyO1UNz437t4YzKqMngupfpEIyXf7Zuofvy9
         lpl/fIZxi/xIyjF7Pw1u+/ZCmpjaOTr66PkxvbjlKLK+clkXcosJl3F5NOW6mSL2uDv6
         W7HjzXYlMxeJQTA5ck8o/Ov4jJq0E/0i4aMSX8Y4InePMgTpJEPCoC+k3+DAhhgwhjAT
         PWew0ycuYdPwCV9E1f0tqBhr6DphXpFtuFqY+L2VWZz1Rkz4aaS/48OyN5K/6JLMDDK1
         tG6T4FUku6+cHN/klrXvde1j7EOckLt6UVNjy5sbwkEDzD5LZLOQwujSKQpdhPfG+vOK
         7rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omEl4yPfArYML/MdFjW82OoYkdDQuGLeGfrwdlfaKrg=;
        b=1roopirG7bJGwNrekivDPHwZuDLQ+ysuPSA6ncDQpXrVN6WbXhz0+Hgi1RD1IG5xJI
         R1dO59nmstKoSNpGPBf9I2bPZXIwdAIXabZwuUPE/n5Q1FFrp0bYxcsvlTGKZ3XYbCHo
         uMz1FyCs5FPKcvvfZJiImiz5O55KdqnGCP6xCRYSeNUAWKRZeKCTeFUOP3qDEa8x9enE
         LghlGjxeSI3weX8EmK/GEkwhk9QZXUnBDzTEFdtHVPgY9n5XJTM5mHCtrZg5flz9p7eS
         pAjz+p8dD5Z39Ee2GiDtX0Y4iNPFUGPoslFggDfC80Ebo7LIgtAgni+rahL8dqqdRYSc
         azGg==
X-Gm-Message-State: AAQBX9dxFu1+1coQs57teaAv6HbfCJovj7YDFJ766xN57FgZunShEcXN
        wTgPsC/JSYXVdQDN8p19J9v3oCx6RGFxxCGJbec=
X-Google-Smtp-Source: AKy350aNiJJYg1pVi5jljr7P/uYj83cSXmoeVmyfrJMT8aKXA5hgmHOHjBThH5lOnKJr0KlUD6Xnt/ABJTsC+1ocoIg=
X-Received: by 2002:a17:902:7d81:b0:1a0:52f1:8ea7 with SMTP id
 a1-20020a1709027d8100b001a052f18ea7mr4581982plm.12.1679948009875; Mon, 27 Mar
 2023 13:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein> <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
 <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
 <20230321142413.6mlowi5u6ewecodx@wittgenstein> <20230321161736.njmtnkvjf5rf7x5p@wittgenstein>
In-Reply-To: <20230321161736.njmtnkvjf5rf7x5p@wittgenstein>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Mon, 27 Mar 2023 21:13:18 +0100
Message-ID: <CAKbZUD1N-jsrro_9ix12vNmjL0iUqqvicCv7MHyj19O5LJs1aQ@mail.gmail.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 4:17=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> It would be very nice if we had tests for the new behavior. So if @Pedro
> would be up for it that would be highly appreciated. If not I'll put it
> on my ToDo...

Where do you want them? selftests? I have a relatively self-contained
""testsuite"" of namei stuff that could fit in there well, after some
cleanup.

> The expectation often is that this particular combination would create
> and open a directory. This suggests users who tried to use that
> combination would stumble upon the counterintuitive behavior no matter
> if pre-v5.7 or post v5.7 and quickly realize neither semantics give them
> what they want. For some examples see the code examples in [1] to [3]
> and the discussion in [4].

Ok so, silly question: Could it not be desirable to have these
semantics (open a dir or mkdir, atomically)?
It does seem to be why POSIX left this edge case implementation
defined, and if folks are asking for it, could it be the right move?

And yes, I do understand (from reading the room) that no one here is
too excited about this possibility.

--=20
Pedro
