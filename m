Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1197526B514
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 01:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgIOXge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 19:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgIOXgG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 19:36:06 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A640C061788
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 16:36:05 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y17so4928310lfa.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 16:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VY3FI+8ua5GfWFJfcYL9CJDi5GxfS9ipQFMk0egquPM=;
        b=Ejf+nB2H8r1U6BUXghESSW2la6WPBsGO2KQMBfcOZ04frdMfiw6sT10vXttnHODQ6i
         rvToxlK44vQDz8BHh8az9FEP/q3ZzjKoTGWJmy+a9q8ESyZu13UWfzvASKK25VnT1DDc
         EgHYogXAOZ3tXTdP4JYasoGmltggzQdxf32e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VY3FI+8ua5GfWFJfcYL9CJDi5GxfS9ipQFMk0egquPM=;
        b=m6J0ZNUwtsPhrqTf1vPa+2/ltjL14IPOfaGQ4+/nIAa/HS3O0SFzMQgCEOHyRcpAgk
         JeS5cvDILwjOBL87XE/mOwQ1HZ2APv16xu8s3sUILVR2pVWSOadnDYIjwus96DJYJ8VS
         MN8SbX4/L/BSe5zCSfKxuuEvCitCvxlf0HdxFQDLh0M6JLe4pvomyyPzVJAc+m/+kUaB
         At5DCDPSn1hYkLocidZAX7HO7xSibrMt2Q7mGiCYaky3L7abmx9MQDc/F5aai0mdVgX0
         ylrdYeB422edOtD+3UHsXd4wmJHGWPYE+rL7vBrS1kPEPy07wrsfa+EA7c5VbVEwdINp
         /rBw==
X-Gm-Message-State: AOAM532XWngOJDt0TAtmct0cW18PRg3CKvxBNRivWiQsOAou/6eS7iyO
        g9eKtc3vp0pNOLrZoF3pjYeGwGFSCoKBsA==
X-Google-Smtp-Source: ABdhPJwJIcbHLhGnsr2UtWyPjqWC9ZaY7JobtTcBj6YaDzCBv9jnEg6XqzVlYu5U0HIWteqaUWySdw==
X-Received: by 2002:a19:d11:: with SMTP id 17mr6769632lfn.0.1600212963126;
        Tue, 15 Sep 2020 16:36:03 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 63sm4237979lfl.130.2020.09.15.16.36.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 16:36:01 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id u8so4981135lff.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 16:36:01 -0700 (PDT)
X-Received: by 2002:a19:4186:: with SMTP id o128mr6576901lfa.148.1600212961230;
 Tue, 15 Sep 2020 16:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net> <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
 <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net> <CAHk-=wimdSWe+GVBKwB0_=ZKX2ZN5JEqK5yA99toab4MAoYAsg@mail.gmail.com>
 <CAHk-=wimjnAsoDUjkanC2BQTntwK4qtzmPdBbtmgM=MMhR6B2w@mail.gmail.com>
 <a9faedf1-c528-38e9-2ac4-e8847ecda0f2@tessares.net> <CAHk-=wiHPE3Q-qARO+vqbN0FSHwQXCYSmKcrjgxqVLJun5DjhA@mail.gmail.com>
 <37989469-f88c-199b-d779-ed41bc65fe56@tessares.net>
In-Reply-To: <37989469-f88c-199b-d779-ed41bc65fe56@tessares.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Sep 2020 16:35:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8Bi5Kiufw8_1SEMmxc0GCO5Nh7TxEt+c1HdKaya=LaA@mail.gmail.com>
Message-ID: <CAHk-=wj8Bi5Kiufw8_1SEMmxc0GCO5Nh7TxEt+c1HdKaya=LaA@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 12:56 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> I am sorry, I am not sure how to verify this. I guess it was one
> processor because I removed "-smp 2" option from qemu. So I guess it
> switched to a uniprocessor mode.

Ok, that all sounds fine. So yes, your problem happens even with just
one CPU, and it's not any subtle SMP race.

Which is all good - apart from the bug existing in the first place, of
course. It just reinforces the "it's probably a latent deadlock"
thing.

              Linus
