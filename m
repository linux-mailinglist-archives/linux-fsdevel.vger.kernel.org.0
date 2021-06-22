Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACA03B0C97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 20:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhFVSMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 14:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhFVSLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:11:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0827C061280
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 11:08:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h15so18847462lfv.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 11:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqKyH/P85UNiqEHVhnOTWzjeuNjUUBapCv+LJwl/SMM=;
        b=Pc4u8ARWhKyeoTp1QuUkXBYBsNhLhb50XcDTJAb7BeD9eYAsVHsqvKwGuLk7Y7WXFh
         sGUzQo5XOG6b7IDfEgtSX4i/xqSSe/y0aDwXDka1ZbLzPxspVFyZB3D6fQnjL8/sEFzR
         UsXtmOmXBwWLZpOf2Kui9wetdxlAxOLjK9fnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqKyH/P85UNiqEHVhnOTWzjeuNjUUBapCv+LJwl/SMM=;
        b=BboP5U09HmwyzKqq23rNkcX10asyYC3puufz6kSUMvNHGcMy2igPzq14KiqL2xRVbM
         zHRtJkaQo0BShWOHi9xFtdnRtdUqQBUrg1oLZQ5jJjnE4muhUzpDhYadSrr/pkfyz1cr
         oUaqf6a1e9rNRyKuIC+a4O8FWnD84aVwLbiZkspgcfoFgODyXnVSlZcNPmZHjtxfBWny
         wqr+e0ZPzit+UrmfnCcA9yJcQecMwjLGKigkaAIDcbYm5P+UDdNpJSmGYL0m4FUP1GR3
         S6D4fkLGKRuTKYcdW16JBk9XhTBB1sE2pK1OI0CTRuE21I/M4SYuwjRhEgZOnL9nukaQ
         Thag==
X-Gm-Message-State: AOAM533mITzhwrD/LTtGwBrjy/jobYo3uHEJzq3CD5deTTuky+lb3eDc
        cF9dvPFoKYkYpIR1U1PuGS8uDYtXAzGefTFMnHw=
X-Google-Smtp-Source: ABdhPJzkTiIZKIfICGLztBOcOf6LsdoYBmtuLYTxLHPVC8wfIMv3p9FIJ/UXZyO53G5IADVSYf4sSw==
X-Received: by 2002:a05:6512:3f1e:: with SMTP id y30mr3914295lfa.260.1624385295184;
        Tue, 22 Jun 2021 11:08:15 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a17sm2283587lfs.59.2021.06.22.11.08.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:08:13 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id p7so37243108lfg.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 11:08:12 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr3746251lfc.201.1624385292112;
 Tue, 22 Jun 2021 11:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk> <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk> <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk> <YNImEkqizzuStW72@casper.infradead.org>
In-Reply-To: <YNImEkqizzuStW72@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 11:07:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com>
Message-ID: <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, "Ted Ts'o" <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 11:05 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Huh?  Last I checked, the fault_in_readable actually read a byte from
> the page.  It has to wait for the read to complete before that can
> happen.

Yeah, we don't have any kind of async fault-in model.

I'm not sure how that would even look. I don't think it would
necessarily be *impossible* (special marker in the exception table to
let the fault code know that this is a "prepare" fault), but it would
be pretty challenging.

            Linus
