Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABABE1E6A25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406192AbgE1TLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 15:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406096AbgE1TLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 15:11:14 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F4DC08C5C6
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 12:11:14 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v16so34840888ljc.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIM8xuF5VWjvw+TNdHJ4kiSd5AWmWcoZ3yv55b5QhmI=;
        b=FUIN+4JKj2QxyK8i6JHV7/j7vy5lRuVpANaKoY2Mlj+WNN0OnhModMVphPtln7hTfr
         6e2HXcUIfOAsDiHQ1XL5v8z2Xgu1ZqPPoh0MtrHTKjhMN1uPF2+2fHIA2yVkvBMEgomb
         B5DSvFfThv/idiSSPqFeMZtDs8M840ZwViIm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIM8xuF5VWjvw+TNdHJ4kiSd5AWmWcoZ3yv55b5QhmI=;
        b=j65I2R9L8p7Ar6dD3TvUOn4oUnmZ5DUagCdqT5I+Jx06b5klC/yBE9JKkJ7gf4AX4f
         Q3oU30NCJlTRmh9iT9TB3m64J8HQP3E2Khp03TOLSPx/bAvClJPe3lTDva6etpimQVbJ
         fpnhydtNIPdcydQm006p1nrmDXXnwTbDnHq8Fj1m756KukHNmfccDb380civ494Q/l0F
         lOdyyC47xQZCRfTZQWbGEOmvTVbxOB3YmQoHGm1DhbVHQpItY77fxibolKixn1ewfUXK
         QGmeSje2JG3W51NKlJtkVYZFbXbfpAQ3rBx52Q9uSFaJ2yC9Px03LE+773Y8t/MI2zJ/
         D/mA==
X-Gm-Message-State: AOAM5325TS3zNULlPx8Z8E3EaiJBveZwRHwDZxhbzHlAam6o7XYbRp4b
        VRG1HDTjxViYofHcbHFiZCjAZcvlx6s=
X-Google-Smtp-Source: ABdhPJxPpKS8xyOsOT3Q6y1XFt4sFYwv4OeJ6bSo54URbeTGs8Kjbsg90y5St6ryACKaswD5ja29MA==
X-Received: by 2002:a2e:160e:: with SMTP id w14mr2215028ljd.66.1590693071478;
        Thu, 28 May 2020 12:11:11 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id f14sm1585158ljp.118.2020.05.28.12.11.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:11:11 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id z6so34768670ljm.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 12:11:11 -0700 (PDT)
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr2356099lfu.192.1590692731704;
 Thu, 28 May 2020 12:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org> <878shcyskx.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <878shcyskx.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 12:05:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbYiVkYy0KpjssAEiEApEUogKpyL1VFWNic4wSp9iDYg@mail.gmail.com>
Message-ID: <CAHk-=whbYiVkYy0KpjssAEiEApEUogKpyL1VFWNic4wSp9iDYg@mail.gmail.com>
Subject: Re: [PATCH 02/11] exec: Introduce active_per_clear the per file
 version of per_clear
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As per the naming of "per_clear", I find the "active_per_clear" name
even more confusing.

It has all the same issues, but doubled down. What does "active" mean?

              Linus
