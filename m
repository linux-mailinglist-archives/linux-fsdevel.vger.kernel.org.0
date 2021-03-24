Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E89347F53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 18:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhCXR17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 13:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbhCXR16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:27:58 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42C5C061763
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 10:27:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k8so22334275iop.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkvrcaymK6nSkgfkJGgjGP9hBUdmwS1OrQXMATb+QVk=;
        b=SyaUL9buRE+4NRrJxT8QWDicV8Zbw3Nwp/PDzCzWvQFIcwsdPe7KDuLRo+AhKkzx4B
         eO+4YSC3shbcQo1ofW917Jep1T5hs1NunTQV/aKRJB87MhV3gKd9DjjI3wVnfxTyQKpU
         FdBLvWKQvgxwGGIt5rLLv5eV4WD+2tS66ftEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkvrcaymK6nSkgfkJGgjGP9hBUdmwS1OrQXMATb+QVk=;
        b=a01qNczW4clO+AafTw5vtqOXaZqIcKQD2g5idEjGdOTSvTUQhQeF5gmcWAugkaa5yb
         zNW5KtTOBbo/Z/f5lbqPitTNxLOv738SLnjyeBPTsc4+3vjLZxW2rXE6QNJYaGlwvv0W
         xmumuQVeb5KQ+0nSmwhu2ZROaWmkp3ARQSCn0htKg/nzHCzrOxHgwdU4xq/GHHEKOFWn
         rFx2aMGVWTVpejECWGdk1LG60/lBed5HYw1X2cFn6o1cY4EKRqCBemSOBpGukP9yg8kD
         QtBl9nt4RDbVFH3TuGEpKyk5dYsuOFWaxS4yzFQo1IKWHm8d3IDRBOcO3avn2U0/4O5w
         4jEQ==
X-Gm-Message-State: AOAM533rwNFkY2gXWiiygJab8vl4FXUy9/QF85X0/vGf5TS/vfwgcx7p
        PPFAnB3/uSQY/sQ78PeadxDAMfeTxBkDtg==
X-Google-Smtp-Source: ABdhPJxKpk+p9kStle/bis9DcI02yEtTSrlmj3f03xgwhPhIx2wEiiDnJ8NPCWq03WglxnDopVVGLg==
X-Received: by 2002:a02:9048:: with SMTP id y8mr3884329jaf.66.1616606877884;
        Wed, 24 Mar 2021 10:27:57 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id f9sm1350171iol.23.2021.03.24.10.27.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 10:27:57 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id r8so22094659ilo.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 10:27:56 -0700 (PDT)
X-Received: by 2002:a05:6e02:2161:: with SMTP id s1mr3520805ilv.161.1616606876703;
 Wed, 24 Mar 2021 10:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <2813194.1616574081@warthog.procyon.org.uk>
In-Reply-To: <2813194.1616574081@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Mar 2021 10:27:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSVA4UnkQySJ1fu9joWJE1g48OxMCBYiApjE40G5ph5Q@mail.gmail.com>
Message-ID: <CAHk-=wjSVA4UnkQySJ1fu9joWJE1g48OxMCBYiApjE40G5ph5Q@mail.gmail.com>
Subject: Re: [GIT PULL] cachefiles, afs: mm wait fixes
To:     David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 1:21 AM David Howells <dhowells@redhat.com> wrote:
>
>  - I've included these together since they are an excerpt from a patch
>    series of Willy's, but I can send the first separately from the other
>    two if you'd prefer since they touch different modules.

It's small enough and related enough that one pull request makes sense.

>  - AuriStor (auristor.com) have added certain of my branches to their
>    automated AFS testing, hence the Tested-by kafs-testing@auristor.com tag
>    on the patches in this set.  Is this the best way to represent this?

Looks sane to me.

Thanks,
            Linus
