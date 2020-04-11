Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4681A53C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Apr 2020 22:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDKU6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 16:58:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38035 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgDKU6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 16:58:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id v16so5206195ljg.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2020 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWYOxbXFRnbNvAiB3r8nYDFiXyRHEzA+YDF9hheoCek=;
        b=d38VMacm5CC5OO6PkiOjO+BmV1qUgyaDDCExE9nJj04S8R8ZwUN0ijSLBpjR9kG73i
         e2H+lVwaVML/nJgrm+owTR9pLMhaaGbA+Fp3vWA06siDzigMBK4wCw4Vmyc4WCSJaqxE
         J1zxKymqjHSdEO1H49jzOWxRMaUDOJSreZ3oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWYOxbXFRnbNvAiB3r8nYDFiXyRHEzA+YDF9hheoCek=;
        b=lJw34RBIuCzAhGNH7ixPiOga5jxKqpqYSQMOdmuJ74ELadyQSovh+G/EWoXqxoKQxF
         WQp6xVS03DWZGeGRUWS+o4t4O5I7/D0MASjqHfL+mQ8citd65s5hiVsfMGG1wmsRNhW7
         +qm5shCQceQmgXJbq4DQ5Mi6ULfkYr3Xp3Fmy35GcIiHq7RoxC+k2iIsME31ay0Ktai4
         taVbg4ss80PbMZp+gAQ0WVVno9f/8BlFa4L2G/aO/LYBKtq20GZ4qEMOAeaZ2YktTcT/
         E0CXKT25Dtf+L6pjs51t0y+EwqSqeff3q6I+r53o3lHwfsylSQoepB79Lo2bjelv6a8W
         APxA==
X-Gm-Message-State: AGi0Pub3JaYljtNO4BP2gcK2ET3ULIfrn3rgV73/vzeCH23XoTd3PaCz
        U6HU3+iiwIn5KwpZSMQlQMs4ulhKq9k=
X-Google-Smtp-Source: APiQypJKPYewnwFs6XTkTyE2S7KaVgUpdVTPccbEX+qO1ja5UJMuY1q2KQeJAYNbzzFJPjXsHFuyGw==
X-Received: by 2002:a2e:8195:: with SMTP id e21mr6404750ljg.49.1586638694245;
        Sat, 11 Apr 2020 13:58:14 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id e16sm5060802ljh.18.2020.04.11.13.58.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 13:58:13 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id f8so3733261lfe.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2020 13:58:13 -0700 (PDT)
X-Received: by 2002:a19:7706:: with SMTP id s6mr6058553lfc.31.1586638692669;
 Sat, 11 Apr 2020 13:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200411203220.GG21484@bombadil.infradead.org>
In-Reply-To: <20200411203220.GG21484@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Apr 2020 13:57:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCAGVwAVTuaoJu4bF99JEG66iN7_vzih=Z33GMmOTC_Q@mail.gmail.com>
Message-ID: <CAHk-=wgCAGVwAVTuaoJu4bF99JEG66iN7_vzih=Z33GMmOTC_Q@mail.gmail.com>
Subject: Re: [GIT PULL] Rename page_offset() to page_pos()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 11, 2020 at 1:32 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> We've had some trouble recently with page_offset() being confusingly
> named.

This makes little sense to me.

I don't find "page_pos()" to be in the least more intuitive than
"page_offset()".  Yes, you have some numbers of "offset" vs "pos"
being used for the position in the file, but they aren't _that_
different, and honestly, if you look at things like the man-page for
"lseek()", the byte offset you seek to is called an "offset".

The fact that somebody was confused by the current name is a red
herring - there's nothing to say that they wouldn't have been confused
by "page_pos()", except for the fact that that wasn't the name.

So honestly, i the confusion is that we have "pgoff_t", which is the
offset of the page counted in _pages_, then my reaction is that

 (a) I think the truly confusing name is "pgoff_t" (and any
"page_offset" variable of that type). Calling that "pgindex_t" and
"page_index" would be a real clarification.

 (b) if we really do want to rename page_offset() because of confusion
with the page index "offset", then the logical thing would be to
clarify that it's a byte offset, not the page index.

So "page_pos()" to me sounds not at all more descriptive, and having
two names (for stable kernels, for people with memories, for
historical patches, whatever) only sounds like a source of even more
confusion in the future.

If we'd want a _descriptive_ name, then "byte_offset_of_page()" would
probably be that. That's hard to mis-understand.

Yes that's also more of a mouthful, and it still has the "two
different names for the same thing" issue wrt
stable/old/rebased/whatever patches.

But if there are enough people who find "page_offset()" to be a source
of confusion, then I'd at least prefer to _truly_ remove any
possibility of confusion with that longer name.

I'd like to have a few more people step up and say "I find that name
confusing enough that I think it's worth the confusion of renaming
it".

We've had the "page_offset()" name _forever_, this is the first time I
hear it being a problem (it goes back to 2005, and before that it was
used inside the NFS code).

Of course, we've also had "pgoff_t" forever - that name goes back to 2002.

But unlike "page_offset()", I do think that "pgoff_t" is actually a
truly bad name.

Which is why I'd much rather change "pgoff_t" to "pgindex_t" and
related "page_offset" variables to "page_index" variables.

            Linus
