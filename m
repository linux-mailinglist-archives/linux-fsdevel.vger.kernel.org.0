Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D823CFC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 21:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgHETZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 15:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgHERZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:25:06 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E29EC0086A9
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2020 07:46:44 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id df16so16389064edb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2020 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3edvsdiBJ+dMkVwgYQe5b56g/OTwtECyNQldn00sS/k=;
        b=pIV877Jp9EOP/kj6De7JQRLtf8VLarGd/I50CrlfCnVlTSEvY4ZesiGKNPAJkMSA9S
         1xuBLUfpu8+qhUlXVyP6XOQ6q0sRV7EwvIwaXpVhCVUJTjQCjAneENJ37v5t/IG4dAAS
         5v+E0LKx1h0Z1Z/D73XVOhVsAP6a9wsqDzKnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3edvsdiBJ+dMkVwgYQe5b56g/OTwtECyNQldn00sS/k=;
        b=nHFEtJBb5QwWZB5GU8dquqCK83tzHzN4CoTNgZ+mqHoOBtcn1HdvGcbUyhtYgSgde2
         oYvTq71TXHwyHpSr7Jk8MZdBPkfNAJup+mmWab2DQeEHkbVocVwJFAjmrjM0zD+hTMLR
         9pTte3fCy5RxuI99S66ea/MAjlyTxby4KHg2hSXiOXyegf2RZW/gZizNahLgaHsPMMhA
         IKBXTwv8AmdaPImakmNyhxCI7mVMfvMJEfaybkxqQG3MqoTlNH3V9WeFXIhTmshA6s40
         iyuayn54jLIj8YeyNkEJ0VXynHsBDrFwSL/7pV0Tc1Z8+W3YIgovWPSyTFSro97phvTn
         lrGQ==
X-Gm-Message-State: AOAM530Rr1vz06Hk22XeGKjVrOZfvlrSIHTIHAwXBTynPs6sj0kDTaHC
        ccPZG1phvLGW31tAh1UlMfDYLb2DjhRvOaLl50Dnwg==
X-Google-Smtp-Source: ABdhPJy96Yk1HJK8pmfb/tsUqlvWao5KdebzpybEXlIErIo0+XHeGRmkn8IkxZto7tV3EPeU3amgjnjkLpPlXf7haIA=
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr3180723edx.161.1596638802798;
 Wed, 05 Aug 2020 07:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646183662.1784947.5709738540440380373.stgit@warthog.procyon.org.uk>
 <20200804104108.GC32719@miu.piliscsaba.redhat.com> <2306029.1596636828@warthog.procyon.org.uk>
In-Reply-To: <2306029.1596636828@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 16:46:31 +0200
Message-ID: <CAJfpegtOguKOGWxv-sA_C9eSWG_3Srnj_k=oW-wSHNprCipFVg@mail.gmail.com>
Subject: Re: [PATCH 06/18] fsinfo: Add a uniquifier ID to struct mount [ver #21]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 5, 2020 at 4:14 PM David Howells <dhowells@redhat.com> wrote:

> However, looking up that identifier requires some sort of structure for doing
> this and it's kind of worst case for the IDR tree as the keys are gradually
> going to spread out, causing it to eat more memory.  It may be a tradeoff
> worth making, and the memory consumption might not be that bad - or we could
> use some other data structure such as an rbtree.

idr_alloc_cyclic() seems to be a good template for doing the lower
32bit allocation, and we can add code to increment the high 32bit on
wraparound.

Lots of code uses idr_alloc_cyclic() so I guess it shouldn't be too
bad in terms of memory use or performance.

Thanks,
Miklos
