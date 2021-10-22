Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00721437F4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 22:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhJVU13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 16:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhJVU12 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:27:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDF3C061766
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 13:25:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a26so603149edy.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 13:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VL4lca6iHsx6oQ/wg6H7clLpP/uNe7ZsGNa7hBqT+88=;
        b=Xm2NbmUwKJoW+515TkyEWt2nuCvePzoqxLYJAFPnOe+lbdK5JzMmyaBBRaBeBIIVr6
         5Y2Ltv7T1OVUR3yQVc1hEpZ4faavbhalIte0tSbwN89GggYecoOBuJphVvusUfCFdqxX
         UgjPbDpPnxZpf2xYUJtsUcqxyBe+gW6XgMyZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VL4lca6iHsx6oQ/wg6H7clLpP/uNe7ZsGNa7hBqT+88=;
        b=PQgECU1RGqXB6GbL/RIU01MqYOjnbcIN0LnKoDkJD46xyJg/k1PrIWhamsIOAzR3Ey
         TBBpT1kajDljQf9Rhyqg3O4u5nzGUz4Ndd3M3yGcNRuOUU/odGr4S55+97v+x8RZna6l
         UhvFzx4wIim92S1BcvY+0jFAApNa3Tx6q6v9HgNLpS5z0uPL2H8mEQcepIu0lDhO6avK
         WcUqJPLgLxvCV0qmjmVdO+sj/egKM4a8e8HMm5v/Nw1zjQoO4+Ph7BBTFgar44iZJVLS
         wpWLf9WtKGYTp0+Ke0lnqFKVcncGtL7ZLxCsFU3PqGUWWvK5wCX0norG5VTh9vx7QyK8
         7kGA==
X-Gm-Message-State: AOAM530tPOwRGpSja/DIPuBxhCQZo0vL7vodB6Tfpkvlg8vLVdD23iel
        KL7uLSPO3Eb3gUrCYctI4AFnZGfIAxpJlQwPx88=
X-Google-Smtp-Source: ABdhPJxqyIAYHAGAxTP8IIR0VwrDkBTpubeQMDwVpcJfJorA/yEGtjOesSX7fRPmWlclOorl94k3kA==
X-Received: by 2002:aa7:c797:: with SMTP id n23mr2773271eds.275.1634934308781;
        Fri, 22 Oct 2021 13:25:08 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id g14sm1060069edp.31.2021.10.22.13.25.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 13:25:08 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id u18so6587462wrg.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 13:25:08 -0700 (PDT)
X-Received: by 2002:a2e:9945:: with SMTP id r5mr2174611ljj.249.1634934297582;
 Fri, 22 Oct 2021 13:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
 <CAHk-=wjmx7+PD0hzWj5Bg2b807xYD2KCZApTvFje=ufo+MxBMQ@mail.gmail.com>
 <1041557.1634931616@warthog.procyon.org.uk> <CAHk-=wg2LQtWC3e4Z4EGQzEmsLjmk6jm67Ga6UMLY1MH6iDcNQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg2LQtWC3e4Z4EGQzEmsLjmk6jm67Ga6UMLY1MH6iDcNQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Oct 2021 10:24:41 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi7K64wo4PtROxq_cLhfq-c-3aCbW5CjRfnKYA439YFUw@mail.gmail.com>
Message-ID: <CAHk-=wi7K64wo4PtROxq_cLhfq-c-3aCbW5CjRfnKYA439YFUw@mail.gmail.com>
Subject: Re: [PATCH v2 00/53] fscache: Rewrite index API and management system
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 9:58 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> and if (c) is the thing that all the network filesystem people want,
> then what the heck is the point in keeping dead code around? At that
> point, all the rename crap is just extra work, extra noise, and only a
> distraction. There's no upside that I can see.

Again, I'm not a fan of (c) as an option, but if done, then the
simplest model would appear to be:

 - remove the old fscache code, obviously disabling the Kconfig for it
for each filesystem, all in one fell swoop.

 - add the new fscache code (possibly preferably in sane chunks that
explains the parts).

 - then do a "convert to new world order and enable" commit
individually for each filesystem

but as mentioned, there's no sane way to bisect things, or have a sane
development history in this kind of situation.

                Linus
