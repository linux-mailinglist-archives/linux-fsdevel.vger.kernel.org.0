Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FD12D4E7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 00:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgLIXGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 18:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgLIXFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:05:55 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B696EC0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 15:05:14 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id h19so5410649lfc.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 15:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjapXZlRvPol1Fdb25tCQ4If3pC/GgbOJVNQ8ykfK8s=;
        b=c31BOie+2yAAa3YQCJKD2zHSpEUhTjjA6XI/jJSDGzjBF7X2zPj5qzC1zOPnGkwafo
         tEdisdWwFm/qbi8tVbAVDxTwFZzPKBjYdf+43YDcdu8/0gyyVAveYsvdNgKa8jNbtBmf
         4OC/LT4BZ/+eY6hdk6qMmLxTb1UfGifzPIkRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjapXZlRvPol1Fdb25tCQ4If3pC/GgbOJVNQ8ykfK8s=;
        b=JNkg1wC2AjgTbyw6umlN/Svk+Rm5r/OKOPjMKqVJjHnsgePQMsGtq2j0UDXwfQaGHl
         ms+8sbVuPv3V/CCRWfyAuZayYnm9lSSSB87Vw9mQex7q+HmtYHLOAEMryJY7dX2TcnqE
         GWiaclAswHM09JZC27G9rs3zdeceLGyypAc88CkUhlyhzIy+1TEeUyK+4f7Sy9HVOTAV
         ntTc29+axBRTLyOjINBK54Ywv31RyRCIriptRPMgvlEuS6NaA/Qe5hmztqO/XP1ObEqZ
         Vp0B3ugmQT86JdOjPbd4E1TQF9z38Q4AdrnKl2viKKpYLpJuR4SCIVkG+Sj75GtcETz7
         q15g==
X-Gm-Message-State: AOAM531OQEG3yJOYXRjSimI39CZOBwcs/GswI/QFds8Wy/CzgiZWt3Y6
        yI/B8KT5ngpC49fIFgpr6PfhgSaQ635gWg==
X-Google-Smtp-Source: ABdhPJxwPCQXnWuv0dPJGnR8s3nS867CXTa4oFqySji/ObiF0gZ8MIJP86NSMgvOa+AytEmoiyfiYg==
X-Received: by 2002:a05:6512:3222:: with SMTP id f2mr1777290lfe.25.1607555112975;
        Wed, 09 Dec 2020 15:05:12 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id a22sm386561ljq.109.2020.12.09.15.05.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 15:05:11 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id r24so5446356lfm.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 15:05:11 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr1594049lfg.40.1607555111139;
 Wed, 09 Dec 2020 15:05:11 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-15-ebiederm@xmission.com>
 <20201207232900.GD4115853@ZenIV.linux.org.uk> <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk> <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk> <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <20201209194938.GS7338@casper.infradead.org> <20201209225828.GR3579531@ZenIV.linux.org.uk>
 <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com>
In-Reply-To: <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Dec 2020 15:04:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGEE9vB2Pw6g=+YqnXMz6z5paK3sxNOtN5CB68VQw=Ng@mail.gmail.com>
Message-ID: <CAHk-=whGEE9vB2Pw6g=+YqnXMz6z5paK3sxNOtN5CB68VQw=Ng@mail.gmail.com>
Subject: Re: [PATCH] files: rcu free files_struct
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 3:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> rcu_assign_pointer() itself already does the optimization for the case
> of a constant NULL pointer assignment.
>
> So there's no need to manually change things to RCU_INIT_POINTER().

Side note: what should be done instead is to delete the stale comment.
It should have been removed back when the optimization was done in
2016 - see commit 3a37f7275cda ("rcu: No ordering for
rcu_assign_pointer() of NULL")

            Linus
