Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868FF28F70F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 18:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389746AbgJOQpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 12:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388946AbgJOQpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:45:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FB1C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2020 09:45:15 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f21so3834035ljh.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2020 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tqw/3zrYvsNT6/LR4jSbjq5V2hTGEWhd2+Uj6nH5og=;
        b=bXA5S6h7u6rIO9U/8BCb6V/8Ll3Ohd0j+gGB1Jz+dDK0SLkxKak/vxGbO5EY80lQrl
         XTyn2JME8K25Dj3a827M7Z/SWLep/EKvRlhLCdwEtMCA+qf0iowvH/YmJnJ6asN3NR8z
         4hY6Ae3XMIxJOCPu1McEBPI5tx2SllEcM2ifs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tqw/3zrYvsNT6/LR4jSbjq5V2hTGEWhd2+Uj6nH5og=;
        b=fzh5Kk1tc8L9P1PD0lCOXxF9efMSj7TWQ+Atk4GKuDrKvHI2vMrvFPiw4EB3tCP44W
         tmcYcAbbw6pN04nx3e0/vQLlk+hL8T2lx1Dy1xnBSxtwGKkpiVQfEZUHQEeXDOyL6zHX
         GVi93OpA8Th9XQfiTHtwWGocEZrts65h1UHlsYo3NnVgQTRz8HgCQqfYcp5b6YDRHE8T
         cAXrQO45/mRaa27mmeafi5QtsGF5AgDDlZTxJg0/91KA7rZL8JZyj74ATo/fglBxZ5as
         QNgSltjLWB6hhpiJ7eFOIO+NG3vvmQlI5AJmaSyAvy/K130J7c38Ua64L16jHaEqI6qQ
         U/gg==
X-Gm-Message-State: AOAM530RRJ3oiMTuUg+Mca7UX2CZ9cqhn9XPuSXgd0yUbCBG+TdhOx0W
        J8ggUdzAPxcST4czcE5Litkb8Hj3dkmZng==
X-Google-Smtp-Source: ABdhPJw2oMM7x15Kv7ogIn/+fPKku1q+Btce/A6iyodGqGyWejJx4oMJTsOLNhKR58hR43xMhw/laQ==
X-Received: by 2002:a05:651c:238:: with SMTP id z24mr1783757ljn.408.1602780313143;
        Thu, 15 Oct 2020 09:45:13 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id j17sm1480456ljg.82.2020.10.15.09.45.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 09:45:08 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id r127so4314559lff.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2020 09:45:08 -0700 (PDT)
X-Received: by 2002:a19:4186:: with SMTP id o128mr1291810lfa.148.1602780308013;
 Thu, 15 Oct 2020 09:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <CAHk-=wicH=FaLOeum9_f7Vyyz9Fe4MWmELT7WKR_UbfY37yX-Q@mail.gmail.com>
 <20201014130555.kdbxyavqoyfnpos3@box> <CAHk-=wjXBv0ZKqH4muuo2j4bH2km=7wedrEeQJxY6g2JcdOZSQ@mail.gmail.com>
 <20201015094344.pmvg2jxrb2bsoanr@box>
In-Reply-To: <20201015094344.pmvg2jxrb2bsoanr@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Oct 2020 09:44:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNooZpC8G4=0dB-OBT5PYuv9d=sqzUXS9Ea_acjrAi_A@mail.gmail.com>
Message-ID: <CAHk-=wgNooZpC8G4=0dB-OBT5PYuv9d=sqzUXS9Ea_acjrAi_A@mail.gmail.com>
Subject: Re: [PATCH 0/4] Some more lock_page work..
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 2:43 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Okay, I see what you propose.
>
> But I don't think it addresses race with try_to_unmap():

I don't think it needs to.

Remember: the map_pages() thing is called only for when the page
tables are empty.

So try_to_unmap() will never see the pte entry, and there is nothing
to race with.

So sure, it can "race" with try_to_unmap like you say, but who cares?
The "race" is no different from taking the page lock _after_
try_to_unmap() already ran (and didn't see anything because the page
hadn't been mapped yet).

IOW I don't think try_to_unmap() really matters. The race you outline
can already happen with the "trylock()" - no different from the
trylock just succeeding after the unlock_page().

So you can think of map_pages() as all happening after try_to_unmap()
has already succeeded - and didn't see the new pte that hasn't been
filled in yet.

I do think there is a real race, but it is is with "__remove_mapping()".

That still happens under the page lock, but it doesn't actually
_depend_ on the page lock as far as I can tell. Because I think the
real protection there is that

        if (!page_ref_freeze(page, refcount))
                goto cannot_free;

it that code sees "oh, somebody else has a reference to the page, we
can't remove the mapping".

But it's entirely possible that I don't understand your worry, and I
overlooked something. If so, can you explain using smaller words,
please ;)

             Linus
