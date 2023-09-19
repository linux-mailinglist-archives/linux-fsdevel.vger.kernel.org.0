Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7367A6EC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 00:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjISWjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 18:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjISWjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:39:36 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E06C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 15:39:28 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bffdf50212so49767551fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695163167; x=1695767967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4EOAYOSdTJZzySl47ZGYx8cRV3+gQBa0MO+WfUGiX4=;
        b=XD6zLnIj++jQksQT4CzYhDtCy6CzUC09XooSw8VECSjiKNcwpeiGU5uCwi6LDm25Hy
         Me+zV84vOmpaJJWWk9cpc4ekl3LbsHbx2Q8fUs7EyyNUB+70t6XDa4W6uKkMDUT3+us0
         gP01mmdJvUvEK/kX7oJ4euZkb3d9rWdze7v3719jkNqZaeMYZIs4A9eRJF1VG3lfekND
         1r6vQYR4hlxOfPZNQgb+YZK5zoHC5+3hKRf4CI4ZKq1WPNsNoy9QtuHCopOnkzXktVHQ
         NqYxH/o4YOubWisznzyNmb6v0rcOrYZ7OBbRmXKj5WUtnyNfTcYza9OxM+hHGIlzbT5N
         eSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695163167; x=1695767967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4EOAYOSdTJZzySl47ZGYx8cRV3+gQBa0MO+WfUGiX4=;
        b=pB23h1CxFQ/ZjtAn/S7PW7sraEOeA5olTpIY5vh8ZnrA8TuVuRiIKpFCzLINyVpKyz
         TqR9jly41/9eZNm91vtVEPz7/x0sdF0rF9GykzCmLKHUI6GCw30xpOxotkjgD5gGBxYk
         uCwTHdzFOBhIbxq9LxpBiThEDNCn6/eVs8suSgsgjPxV4TzNeVqor+THDPRn85WEk5Ll
         5ylG/nSC6GudYiF3RWKqWChVeJYgalKay+taGfZQZCOKiJc4C9VM9ApnQTsS2jb2tqif
         8oVtfUDsj3tQEIJ8xChDN7aQ59AEfm6jh+YGDrGCzMnYPJqASabzBmp38Z3W3GkedO/7
         oG3Q==
X-Gm-Message-State: AOJu0YyNPm4XG9yHCjlgp50tk2v+/noSSUPH3ZnqWZ2m3pAViwjOu8tI
        5vTvz+RK7xDx2FCQKlL/uamokQOAueuyfy8dUXFHCThj1qo32RVlD7c=
X-Google-Smtp-Source: AGHT+IGGfEiSjnqJR6q4MlPxBttRVFIpiwjLG8LLmJRqBb5BwFwXS449AXPvD2cc2y7pGEhmjcIKbu3fQ83LZdlANV0=
X-Received: by 2002:a2e:9919:0:b0:2b6:eb5a:d377 with SMTP id
 v25-20020a2e9919000000b002b6eb5ad377mr671269lji.5.1695163167101; Tue, 19 Sep
 2023 15:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230919080707.1077426-1-max.kellermann@ionos.com>
 <20230919-fachkenntnis-seenotrettung-3f873c1ec8da@brauner>
 <CAKPOu+_ehctokCKHFZgqs2NksE=Kva80Y5xjA705dNCbtcDxgA@mail.gmail.com> <20230919-deeskalation-hinsehen-3b6765180d71@brauner>
In-Reply-To: <20230919-deeskalation-hinsehen-3b6765180d71@brauner>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Wed, 20 Sep 2023 00:39:16 +0200
Message-ID: <CAKPOu+8F2fZerfaD=-w68p6Hw5EGdjWdzj8F9OYBcQx_ara22w@mail.gmail.com>
Subject: Re: [PATCH] pipe_fs_i.h: add pipe_buf_init()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 4:16=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> You're changing how the code currently works which is written in a way
> that ensures all fields are initialized to zero. The fact that currently
> nothing looks at private is irrelevant.

Two callers were previously using a designated intiializer which
implicitly zero-initializes unmentioned fields; but that was not
intentional, but accidental. It is true that these two call sites are
changed, now omitting the implicit (and unintended) initializer. If
you consider this a problem, I'll re-add it to those two callers. But
adding the "private" initializer to the new function would also change
how the code currently works - fot the other callers.

It's only relevant if the "private" field is part of some API
contract. If that API contract is undocumented, we should add
documentation - what is it? I'll write documentation.

> Following your argument below this might very easily be the cause for
> another CVE when something starts looking at this.

When something starts looking at this, the API contract changes, and
this one function needs to be adjusted.

Without this function, there is not one function, but an arbitrary
number of redundant copies of this initializing code which all need to
be fixed. As I said, only two copies of those currently do initialize
"private", the others do not. Therefore, my patch is strictly an
improvement, and is safer against those alleged future CVEs, which is
the very goal of my patch.

> Wouldn't it make more sense to have the pipe_buf_init() initialize the
> whole thing and for the place where it leaves buf->private untouched you
> can just do:

Would it? I don't think so, but if you insist, I'll add it.
I prefer to leave "private" uninitialized unless there is a reason to
initialize it, for the reason I stated in my previous reply.
