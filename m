Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94EAB3147
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2019 19:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfIOR7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Sep 2019 13:59:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42623 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIOR7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Sep 2019 13:59:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so31609540lje.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2019 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFQ6bLEw0DqXlupLVO397W33Z9udTXaB1tTGFV03T54=;
        b=YaFGb+aTEgk0cbA7zrNK6fWBL4dLqYgY6pCQ0cxjeZjBOIcsxidFhiCb/ZBSRorHSs
         hg+lIfR1CrLgEsRsulrQuW5G8eAUbsa6GNFVWh+xqRckDxqvUe2WzqgLdw5PDX+Ri8Z7
         LGsM/BRv7P4bM4a9GQ3S2blH5lEySy1CrClPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFQ6bLEw0DqXlupLVO397W33Z9udTXaB1tTGFV03T54=;
        b=I5jcKJQ9smMN+wNwZslKVI+gKi4549QvkItiTly2btKL8m6oxeLxVE1OgRF7Sy0Obb
         Uzc8ZACwUMwiLkmw86wlwe9vMh5f5Mor+O8OD0dX9+lwRsr5gthDyAdinLReXOqhQjEi
         rHpM5m5WYkqamE4pbjqJe70T2qUMwxXqLO3OI9/KYPIZP+jJ+d0XAoyxlnv2+fdHQWis
         a7ddNpo//bG7da1VbRGuoX9BDApxnegk2yiD1hEH1/y+b7e/a1bCZo5lajGVCj7HagEU
         euDhP9H42s2ys4JklkUCuYhCoXgWc6O9CScmqZ8XeBj5jT4/M7G6AqpTCgO4pGs07B5v
         rL4w==
X-Gm-Message-State: APjAAAUXWasgxPICnoupuabVdGpLN9eyrXG5/rC6Ci5G7p0wtuMzn82P
        lY63336NAkPqEneUOplAz5TylkaLc8c=
X-Google-Smtp-Source: APXvYqywa5F6vESyH9H4jyeUED0XJCcm1RF409+khFxLNb3OTz8foSQnRnBin0sb6rqL/hwM6mOD1Q==
X-Received: by 2002:a2e:861a:: with SMTP id a26mr29386627lji.163.1568570349434;
        Sun, 15 Sep 2019 10:59:09 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r19sm7928536ljd.95.2019.09.15.10.59.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 10:59:07 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id r134so25644685lff.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2019 10:59:06 -0700 (PDT)
X-Received: by 2002:a19:7d55:: with SMTP id y82mr36222080lfc.106.1568570346434;
 Sun, 15 Sep 2019 10:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com>
 <20190910215357.GH1131@ZenIV.linux.org.uk> <20190914161622.GS1131@ZenIV.linux.org.uk>
 <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
 <20190914170146.GT1131@ZenIV.linux.org.uk> <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk> <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk> <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk>
In-Reply-To: <20190915160236.GW1131@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 10:58:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
Message-ID: <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and d_alloc_parallel
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 15, 2019 at 9:02 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Could be done, AFAICS.  I'm not even sure we need a flag per se - we
> have two cases when the damn thing is not in the list and "before
> everything" case doesn't really need to be distinguished from post-EOF
> one.

Agreed, it looks like we could just look at f_pos and use that
(together with whether we have a cursor or not) as the flag:

 - no cursor: f_pos < 2 means beginning, otherwise EOF

 - otherwise: cursor points to position

> > I wonder why we have that naming to begin with, but it's so old that I
> > can't remember the reason for that confusing naming. If there ever was
> > any, outside of "bad thinking".
>
> ->d_subdirs/->d_child introduction was what, 2.1.63?  November 1997...

Heh. Your google-fu was better than mine.

> http://lkml.iu.edu/hypermail/linux/kernel/9711.0/0250.html
> with nothing public prior to that.  What has happened to Bill Hawes, BTW?

I think the original submission predates that by some time.

Afaik, the original dentry patches were for a PhD thesis or something
like that, and in the original form is was not used for caching and
lookup, but to generate filenames for logging.

.. and that may in fact be why it had the list of children being
called "d_subdirs".

Because the dentry patches originally were about tracking the changes
to the directory structure, and so only tracking subdirectories was
interesting.

As to Bill Hawes: "Now there's a name I've not heard in a long, long
time. A long time."

I don't find anything after 98.

                Linus
