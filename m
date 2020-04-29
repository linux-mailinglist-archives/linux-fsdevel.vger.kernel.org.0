Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD611BE451
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgD2Qt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 12:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2Qt0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:49:26 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61111C035493
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 09:49:26 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 188so2246996lfa.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9Uuz2eH1rEC3Rsd9pWrnSIaGFJoBuGHkEpyj9FO1RU=;
        b=fNkYlfC7XyU0na36V1nAsEErxJD6SCdd001tONSj5QzCTF5pfnhtkJHTnLvT4RbjHZ
         Esmpn/Ja4kfMTNbK4V/ULBUaFnl8J/DehN+PSbsUTUNm9u5a0/1rtLVU7yIw59uOmHc1
         Oz8J1e1DSH0V3mg6CW+Ys3Xe1HiKJDyaEj9z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9Uuz2eH1rEC3Rsd9pWrnSIaGFJoBuGHkEpyj9FO1RU=;
        b=q1625MH9SIjIVQr4p0g8i3ZFAaAChJ9WAA358LA+WSvPkJ2kkSc3hOfWo3q3fU9gI6
         lAtwpuAL3JWmgO1yGvuEjfq12H5tS6V0KuUtdereAQorqP9jKILdoivg12QvznSefAxb
         6S8pdyNh/+30S74PljQW1U7m7Fg+ETbps7iNwtagtdkzkZxM7MGnOKMIpEuTDXNBitvg
         JReFwZY3y3vEbjhZiBkij2OP66y78WPNZi6hb/YRax6ZZmZ0LvBe9Ctzurc9lfWMCecl
         G2wMsRE5TCr4KNaOXDzJWgpSSRfb+iAp6ai8TS92qKthjsVCAAq9RZf4N3PNrTMkuBs0
         veHw==
X-Gm-Message-State: AGi0PuZKqAyCARD+wVtzpCAzS4wca5MQUdUy1Ps9imJBanE59jWUTosM
        SPnNDn9ySTkBHCQ6s1n9b+toeEWo3AQ=
X-Google-Smtp-Source: APiQypIRBSIFDtuWZ9L5s7T4/z99JbNw6Nbv6+vrAQ1x5wdwsUMuB/2zOS70knSNeR4GbEKH6+TovQ==
X-Received: by 2002:ac2:5235:: with SMTP id i21mr23232632lfl.73.1588178964299;
        Wed, 29 Apr 2020 09:49:24 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id k6sm2959604lfm.91.2020.04.29.09.49.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 09:49:22 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id j14so2256025lfg.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 09:49:22 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr23676248lfl.125.1588178962247;
 Wed, 29 Apr 2020 09:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <158810566883.1168184.8679527126430822408.stgit@warthog.procyon.org.uk>
 <20200429060556.zeci7z7jwazly4ga@work>
In-Reply-To: <20200429060556.zeci7z7jwazly4ga@work>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Apr 2020 09:49:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHoa0onB0KTthLXeHNNBupcPOdf38OEoFFy3ok3nOeJA@mail.gmail.com>
Message-ID: <CAHk-=wiHoa0onB0KTthLXeHNNBupcPOdf38OEoFFy3ok3nOeJA@mail.gmail.com>
Subject: Re: [PATCH] Fix use after free in get_tree_bdev()
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:06 PM Lukas Czerner <lczerner@redhat.com> wrote:
>
> This fixes the problem I was seeing. Thanks David.
>
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Well, it got applied as obvious before this, so the commit log won't
show your testing.

Commit dd7bc8158b41 ("Fix use after free in get_tree_bdev()") in case
anybody cares. Didn't make -rc3, but will be in -rc4.

          Linus
