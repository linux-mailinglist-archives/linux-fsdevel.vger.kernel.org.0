Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD447791B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 17:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbhLPQbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 11:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbhLPQbj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:31:39 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C9EC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 08:31:39 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z5so89699354edd.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 08:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0tfi6GWjQ8PFg1rClE3QlQWN0cjd+HtwnOPSpFHrtM=;
        b=ZUmg4A/7HjP6eAASANt+4keQHSopn9fF9fVMthVZu/c/YjSSrDTZVizCt53w3pjZTz
         ALdrT2CetN7y0UB7HWM9QXKDG/IjiRvTGiiwA+eAdMgcIrCfVT3wEDCrbPcgGrLjCxw0
         amQe/8kTyLnJyS+EwJHlBCCyQJgU9esnPnqpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0tfi6GWjQ8PFg1rClE3QlQWN0cjd+HtwnOPSpFHrtM=;
        b=05OHc8BPsCZQKDZi5vVm/t7k3maK4mFMo0J6BdcoDfWBwwXlJSKpD1Q5cOoowYvNJ0
         WDhSvDPpG7ncRZ1zU++QHNIcm8ixZ1BPnvrjRZbUEjz6LAsBq2iOWZI+eEY1Gq+tmYWI
         j7x7wTShfnmtktJLyrn282vUJ95p1IwpCNSJqUfagb8jvb7FPnQUQi1kQbTYzGuAWjaE
         7bJzCSHyU0rHHKu9tBvunNjXvyQ1c5uUbOzUSaM5sX3vX3bRyVSYMRzXJE+tZzh5R3Wh
         j598QBxPexPI5+6gttT3t8D8m5N4DQ8ww1znAV+m6HwyDp3v8gKEHst0FgRjNyjLljgE
         U2aQ==
X-Gm-Message-State: AOAM533D9vlpEDXYu8bwhhgax06YaN61jRpmau/MC3QScXOd6EU+FLOm
        3CWP5BlaLx3LBjly4hzQGG0hXNFSfkrBqudx
X-Google-Smtp-Source: ABdhPJw191VPlN3g/nBdfOVMTsHebwmrfyPDWuHJQMRCi05rlSiVtdTGQHrz+7uHaPj6XnTZErm7AA==
X-Received: by 2002:a05:6402:40d3:: with SMTP id z19mr21808653edb.185.1639672297478;
        Thu, 16 Dec 2021 08:31:37 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id k19sm1161081ejv.38.2021.12.16.08.31.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 08:31:36 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id v11so45170816wrw.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 08:31:35 -0800 (PST)
X-Received: by 2002:adf:d1a6:: with SMTP id w6mr6315246wrc.274.1639672295092;
 Thu, 16 Dec 2021 08:31:35 -0800 (PST)
MIME-Version: 1.0
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
 <163967169723.1823006.2868573008412053995.stgit@warthog.procyon.org.uk>
In-Reply-To: <163967169723.1823006.2868573008412053995.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Dec 2021 08:31:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi0H5vmka1_iWe0+Yc6bwtgWn_bEEHCMYsPHYtNJKZHCQ@mail.gmail.com>
Message-ID: <CAHk-=wi0H5vmka1_iWe0+Yc6bwtgWn_bEEHCMYsPHYtNJKZHCQ@mail.gmail.com>
Subject: Re: [PATCH v3 56/68] afs: Handle len being extending over page end in write_begin/write_end
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 16, 2021 at 8:22 AM David Howells <dhowells@redhat.com> wrote:
>
> With transparent huge pages, in the future, write_begin() and write_end()
> may be passed a length parameter that, in combination with the offset into
> the page, exceeds the length of that page.  This allows
> grab_cache_page_write_begin() to better choose the size of THP to allocate.

I still think this is a fundamental bug in the caller. That
"explanation" is weak, and the whole concept smells like week-old fish
to me.

         Linus
