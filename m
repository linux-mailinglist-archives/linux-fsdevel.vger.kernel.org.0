Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18958242E75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 20:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHLSSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 14:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgHLSSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:18:45 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAABC061383
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 11:18:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id s9so1675314lfs.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5NX6kMDP5qmBpQCPkWzwhmOd6ct20g0CcQwpleYHFc=;
        b=US2q3MwnTSjWfqpie9O3CRcizx9uSCz4S3vkL7p/ooj414+R066sTYC3Q4A4VD1OD6
         WbBdeRdiPaC//fSZsRo3WOoZpu8gTtAt7k7tMZ8hwJVqEhGHjLO4oOIslMbvG22T1LrR
         FvpBZZmDKWHcNGLeiM+6hKFDuuH8IvkNuF9T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5NX6kMDP5qmBpQCPkWzwhmOd6ct20g0CcQwpleYHFc=;
        b=nSBk65q7JjayAP2WykEz8Q1ID4Y4GexJoM77k1Dl8UEa8fV/n+AcmjZz2PCjA/h0l2
         bqRb6Vp2pwynJOwMkbF/AkMziUKlHxb2RS+NQP61yk3nGMqzp8ShBCWBEV6TR85yxbFG
         xzifW0dvhH3K28/74rw2tMk4GHhpr6LVsSK00AZGtLQTw1PRLvCU/P6g/Jmd6c8EXEMa
         LVYtaBEnxrJ8SmKyJJ/BGT82FGCN9nwxGyrMgUKN80wcrokNX3zkExEDfCtEI5w/UjR6
         RB4azdAxuYvLF3cvYH6t3HhNIYuT1qF7Mvv1U36DSm/7rfOsw8JPzvt7jbNYD3qtEQVZ
         BV8g==
X-Gm-Message-State: AOAM533JSbaVRL3hv1nxoeb1zIWO3Dbakpl0Kp4CLZyzVP/UmEtYeCqO
        pLbuz4knBM5/NAhES836rXqWftXihwM=
X-Google-Smtp-Source: ABdhPJybhohY7L8i82mN3TCG2ZIx8hW6Grid3cwoTptGx7kQ3iQoIbKRInTKSB78h6Zvp402ETwPVw==
X-Received: by 2002:a19:cccc:: with SMTP id c195mr323260lfg.88.1597256322823;
        Wed, 12 Aug 2020 11:18:42 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id k23sm585354ljk.37.2020.08.12.11.18.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 11:18:40 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id b30so1647542lfj.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 11:18:40 -0700 (PDT)
X-Received: by 2002:a19:408d:: with SMTP id n135mr315813lfa.192.1597256320205;
 Wed, 12 Aug 2020 11:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk>
In-Reply-To: <52483.1597190733@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 11:18:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
Message-ID: <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 5:05 PM David Howells <dhowells@redhat.com> wrote:
>
> Well, the start of it was my proposal of an fsinfo() system call.

Ugh. Ok, it's that thing.

This all seems *WAY* over-designed - both your fsinfo and Miklos' version.

What's wrong with fstatfs()? All the extra magic metadata seems to not
really be anything people really care about.

What people are actually asking for seems to be some unique mount ID,
and we have 16 bytes of spare information in 'struct statfs64'.

All the other fancy fsinfo stuff seems to be "just because", and like
complete overdesign.

Let's not add system calls just because we can.

             Linus
