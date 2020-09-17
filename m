Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEFC26E4E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgIQTC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgIQTA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 15:00:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D11C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 12:00:29 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n25so2981157ljj.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QaNy7skFdocpIi7yXUk0cvyZ61htoWtJGhoFEfuldNs=;
        b=NbAnzyB2Mzc30Bxhxt2G/fphVVd0HhTHio6XwB2c+aD3xh1gYYDxBMBwfzTwVjgO1y
         2U/0SPniX5eHV7f8q+a1tgEHnXXLTpFyJIRbU1hQyswRasCEIfdyPNwxrAhx/TtmWgNp
         D9gNAm/JHCes0tuZjojw2IFaa40CTEvGQa+Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaNy7skFdocpIi7yXUk0cvyZ61htoWtJGhoFEfuldNs=;
        b=NbgZnGb9vZzMgz3ltt/SzQ76xNLvkZbauP8qhC8AuR9sPnEb3QzXiTtMrl4Rc14hKl
         qZVYHRNQ0wuepfaKN3MK7n+CAFXKXt8gUDQHT2nWzv4Ns4Gj8bHhIq2IXOvAN5Our1Bj
         djbNCueFqd5MpLNkXjt+9e6xSiCI+kTqD9tZWcykiEw2s82D7JaRQkWy7GQnFwJROlyZ
         lEf4T7zgvDmDurla/j021W7zEmu5LxE6VSrAE7Jg1xQCnncQPt6GogkAN9kBSuQXjZsg
         tHXO8pwhoLEr94M+yETR0QhB8HPTINIFFSq0FiO6Cf9+CVCeHXCYfZBz1j2CmO38eHty
         RlPA==
X-Gm-Message-State: AOAM531N3tLHPKdL1H7CjnF5Izc/Qcy7MkO+gtMI5FDZFRYNQunANV2e
        VB7+iioasi07nCAnA+G7sAjutzpapxRCAQ==
X-Google-Smtp-Source: ABdhPJzO+HG803tS0WPoPq+HprpDjgBeSjM/ahzoRM9yKAsxOgrLuIXPszEVSBgjN5Uxna4XbAfmWg==
X-Received: by 2002:a2e:3c0f:: with SMTP id j15mr8486253lja.461.1600369227165;
        Thu, 17 Sep 2020 12:00:27 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id c7sm80527lff.116.2020.09.17.12.00.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 12:00:25 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id b12so3345664lfp.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 12:00:25 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr10423309lfg.344.1600369225145;
 Thu, 17 Sep 2020 12:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org> <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org>
In-Reply-To: <20200917185049.GV5449@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 12:00:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
Message-ID: <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:50 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Ahh.  Here's a race this doesn't close:
>
> int truncate_inode_page(struct address_space *mapping, struct page *page)

I think this one currently depends on the page lock, doesn't it?

And I think the point would be to get rid of that dependency, and just
make the rule be that it's done with the i_mmap_rwsem held for
writing.

But it might be one of those cases where taking it for writing might
add way too much serialization and might not be acceptable.

Again, I do get the feeling that a spinlock would be much better here.
Generally the areas we want to protect are truly just the trivial
"check that mapping is valid". That's a spinlock kind of thing, not a
semaphore kind of thing.

Doing a blocking semaphore that might need to serialize IO with page
faulting for the whole mapping is horrible and completely
unacceptable. Truncation events might be rare, but they aren't unheard
of!

But doing a spinlock that does the same is likely a complete non-issue.

              Linus
