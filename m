Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE48B7017
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 02:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbfISAZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 20:25:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43771 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbfISAZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:25:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id u3so957238lfl.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 17:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBc/eYJTOLPPQiZ5t0llKwVn5FhzICC4mWTmMrXjDEU=;
        b=WIbuDCmG9hzDesKroizOBqRXGwONhNP4QrBll03slXqZ8b1BB3vzPCdVc22psjVksw
         jQmVL7xCO/XlhDKxOO0QWvn92j6bBHADgUhpwQrr60PpwgBbzneGC/apON1Wc9JDdf/B
         qoPD6tb+dylFDQ1HADe1c0C8c5aPCYN+8e5og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBc/eYJTOLPPQiZ5t0llKwVn5FhzICC4mWTmMrXjDEU=;
        b=qEyRiOxyKiLT+Vmy82Hr6M5XsAGlRGsL4rlDHizp1cYXSeg3kH14sm9Mm2VwsP+L16
         EiXeK7Q2W9oswxfpi9Eg8SdsLv6xCpQeiAbmkBW/J3PLMzSSm6sFRUmWS8P5p0TbxoQw
         w1M0ooLm/k5hiv9jXNLrAnp7EPwv2iYbUd+PNtXZP35TX00OeW4kLIgPLWSbrhqE780m
         dsVTpcPstUT3ADPGhRlTCn+Q4dlPpCuF0tOFbcH7eDx+FlS8P40KySmaF8+dWafibBVp
         IFFEXnf/FNIYKQWvrp9WHoyZ8CW5rYLNNiK4SUkyH5HyXvpJvE2E4uL57f7xzzdssRE0
         SeEg==
X-Gm-Message-State: APjAAAX3+wWKIgwGXVq7UgpzL7FFnacnMf96WdvG1gNTsi59ufPN2A/N
        kU9vTGFAJL2ZRu2apViJGsYmXFCs0fU=
X-Google-Smtp-Source: APXvYqw0Z9sMoIMtSxkvStzpK23kuNGPBQfUEDr3UK7RwZbFpU4hs5jm5jjJQnUO2Jd7g6YCu/nRIg==
X-Received: by 2002:ac2:5965:: with SMTP id h5mr3383115lfp.129.1568852709254;
        Wed, 18 Sep 2019 17:25:09 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id h7sm1297668ljc.39.2019.09.18.17.25.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 17:25:08 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id a22so1772137ljd.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 17:25:08 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr3846937ljs.156.1568852707845;
 Wed, 18 Sep 2019 17:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <16147.1568632167@warthog.procyon.org.uk> <CAHk-=wgJx0FKq5FUP85Os1HjTPds4B3aQwumnRJDp+XHEbVjfA@mail.gmail.com>
In-Reply-To: <CAHk-=wgJx0FKq5FUP85Os1HjTPds4B3aQwumnRJDp+XHEbVjfA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 17:24:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOw-YDpctcdTwsObUuwSv4+SC+O68kitxzPX-4nW74Kg@mail.gmail.com>
Message-ID: <CAHk-=wiOw-YDpctcdTwsObUuwSv4+SC+O68kitxzPX-4nW74Kg@mail.gmail.com>
Subject: Re: [GIT PULL afs: Development for 5.4
To:     David Howells <dhowells@redhat.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 5:22 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Commit messages need to explain the commit. The same is even more true
> of merges!

Side note: that wasn't actually the only problem with that merge.

The other problem was that neither of the merge bases made any sense
what-so-ever. Neither parent was any kind of "this is a good starting
point" for anything. You literally merged two random trees.

So even an explanation isn't really sufficient. You need to start
looking at what you're doing, not doing random crazy stuff.

                Linus
