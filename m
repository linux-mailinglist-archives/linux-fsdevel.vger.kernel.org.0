Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A67116363
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 19:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLHSSN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 13:18:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40212 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfLHSSN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 13:18:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id s22so13049625ljs.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Dec 2019 10:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bP+MLqv2/4jxjq5G8WI3V8blQrwy5vvH8NjA0Oq9xU=;
        b=H0B9voLfv9AYLRDixmAeg/5DRF8QLotazZN/4owvkzDMXfPsktWaen4Q3k9MedABQL
         0pB2E+DsxZ88pf8Iftm8Zpi/eUzhjTeP2HrbKUH1z9La6YaZoUY5Mc7J6SV7VX3rGun9
         NOn+0S2wMJe3ABAu0HEETzU4Av3UFzbmNvuFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bP+MLqv2/4jxjq5G8WI3V8blQrwy5vvH8NjA0Oq9xU=;
        b=dSe0Wnu5yBYRwkdzxODzg/U99sWF2K+DqQ6yuEYXewX5QUJNz2hpvXmcmfPm6JantP
         NZOS7AOKlqDxkNBQjUpq75eiw33Ks2A3uMeBHhnqT6NFzW9S4O6hIT8zEQPmJB6ZF9sA
         aeUebaSaPzmT7TpiCowRfw/UH3sSkbk6xTh02WuXAAOloOTpWo63QF4sGKM/CgGasK2Q
         +jT4OO45QUH9xK2lsGew+QpdFkPb73JeloXuj9evSoq4037Kjd+wTPWx3oiIerYEHsZB
         L/MXYIjX98a4eZAMyfgK5bWZ0nAWrGZhk/ijZFnN8iuamAwUulxV6hT5w67nN6gNh/a2
         bfXQ==
X-Gm-Message-State: APjAAAXExA6sM77KxdViRE13KJ+9HiqHP9wuNHEB3ps6/jl36vl9VrYf
        Gxm4Kqrs+jpySYvs3eddD1JNh/YPShE=
X-Google-Smtp-Source: APXvYqw7GoGUIIhJhbP+fLhafu1CdctjAVgULNn4JlvqdOSR7oap0CpNrnr0P4oznko95JoZ2o27jA==
X-Received: by 2002:a2e:b52a:: with SMTP id z10mr14121914ljm.178.1575829091211;
        Sun, 08 Dec 2019 10:18:11 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id v2sm9845287ljv.70.2019.12.08.10.18.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 10:18:10 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 9so8919203lfq.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Dec 2019 10:18:10 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr10244080lfo.134.1575828667708;
 Sun, 08 Dec 2019 10:11:07 -0800 (PST)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <20191206214725.GA2108@latitude> <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
 <20191207000015.GA1757@latitude> <CAHk-=wjEa5oNcQ9+9fai1Awqktf+hzz_HZmChi8HZJWcL62+Cw@mail.gmail.com>
 <20191208175602.GA1844@latitude>
In-Reply-To: <20191208175602.GA1844@latitude>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Dec 2019 10:10:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgh9zUy9nbiCgGjtrgw1V9Vk=01Ncju-0iib5Jn-V1arw@mail.gmail.com>
Message-ID: <CAHk-=wgh9zUy9nbiCgGjtrgw1V9Vk=01Ncju-0iib5Jn-V1arw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 8, 2019 at 9:56 AM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> whereas with a fresh cloned repo I get:
>
> v5.4-13331-g9455d25f4e3b
>
> I assume the later is right. With this version the bug seems to be
> fixed, regardless of the commit count. Tested with different websites
> and firefox works as expected again.

Ok, good. It was almost certainly the select/poll race fix - Mariusz
Ceier reported a problem with youtube hanging, and confirmed that the
poll/select fix seems to have cleared that one up. I suspect that your
hang on fb and spiegel.de were the same thing.

So I think the pipe code is stable again with current -git. Thanks for
reporting and testing,

             Linus
