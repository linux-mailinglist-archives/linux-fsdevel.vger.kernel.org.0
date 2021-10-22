Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1501437E87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhJVTYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhJVTYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:24:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3DAC061766
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 12:21:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u13so257088edy.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MIYbiqTAgOZcVD7o78/iMiC5v0PdYgNzQoieL1dnhA=;
        b=NpDhMd+K20exoXtDQK8VxJJZx2jeiKfduhNixPkqDW3AhUt9xwYIfDXlKXTXwxZNO2
         rNDgVo6Zt+p6dmQo5I+h/tgPznlF+wHZKxE1z8e+Cg4jyabcAJUUy8ldhvdjRTw7E0CK
         ZCzjOxlNRUs2SJlFmk4Z3ttWsxuy0Et3Uj530=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MIYbiqTAgOZcVD7o78/iMiC5v0PdYgNzQoieL1dnhA=;
        b=Q7fxP9iDRCZK496Mi2w8P2XxnTYc6MA5C9B4mbrjveP9b5BjR5KdR+JWzBEy8nM91o
         I3Pd26TaZBTrSh8NKqH/7uwJdPUioZT6iaUGDAFzvECPnVk9r718RxA6+5dvgd8S0jJZ
         7HxK1F7HOzD6Q+MXJuQo6TtJ/QleIBRY1l1CmXwXX+Juil/v2FNUbCg8t+x03/4Y1k0w
         V7TW2gjULVIzi3HkpDTJBKYv41RZtB38WlMJI9WuKJjZln3eOG93SUuHp+TDY6S+dgN4
         3/7BmVHL7ZDKEkswYrLfVWk6flmDRVV4MHq/aYsV3X/WtinDLtqgYPc2mMZT26TO8f0E
         eM3Q==
X-Gm-Message-State: AOAM5307kA871nwUWTSDvG6jWG+Kc3W1X3A2liQrZHMwJDh5EWmQ1Fuf
        MbZscaT+JpdAcV9wDOD/NpYTEEzkKAGP0vz6
X-Google-Smtp-Source: ABdhPJxVRXaQqv2Tc6X9CpzbiXGXRh3oRYoKRTggt4XFTAlhqfifHmMMand9lYjY6dz+jp1ngM72rQ==
X-Received: by 2002:aa7:c359:: with SMTP id j25mr2457095edr.348.1634930501885;
        Fri, 22 Oct 2021 12:21:41 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id z4sm5581979edd.46.2021.10.22.12.21.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 12:21:41 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id k7so3118193wrd.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 12:21:41 -0700 (PDT)
X-Received: by 2002:a19:ad0c:: with SMTP id t12mr1362164lfc.173.1634930491229;
 Fri, 22 Oct 2021 12:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Oct 2021 09:21:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjmx7+PD0hzWj5Bg2b807xYD2KCZApTvFje=ufo+MxBMQ@mail.gmail.com>
Message-ID: <CAHk-=wjmx7+PD0hzWj5Bg2b807xYD2KCZApTvFje=ufo+MxBMQ@mail.gmail.com>
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

On Fri, Oct 22, 2021 at 8:58 AM David Howells <dhowells@redhat.com> wrote:
>
> David Howells (52):
>       fscache_old: Move the old fscache driver to one side
>       fscache_old: Rename CONFIG_FSCACHE* to CONFIG_FSCACHE_OLD*
>       cachefiles_old:  Move the old cachefiles driver to one side

Honestly, I don't see the point of this when it ends up just being
dead code basically immediately.

You don't actually support picking one or the other at build time,
just a hard switch-over.

That makes the old fscache driver useless. You can't say "use the old
one because I don't trust the new". You just have a legacy
implementation with no users.

              Linus
