Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8893436D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 03:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCVCwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 22:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCVCwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 22:52:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA91C061574;
        Sun, 21 Mar 2021 19:52:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id n11so7671020pgm.12;
        Sun, 21 Mar 2021 19:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=BvabUkO3PLx1bZnAqoYpXYM9Bgtuk0OU4X8sitVluP0=;
        b=XqP7Sfeufw2quyKHxkQqBKXWkqz5ZfzGAvUW27kPbsphpmA5DWcpO3bjdFF9WiHA0N
         UN91SZiWQvHrOEuxWfvxrnoEeKPlBvTu2fb/nznz/i9hrQ9FQfdX+QjRoBD2m45tYXIX
         dgfzOQhXXH7yeTtnmZsdrfv/83K15up/toOlxdzCTwLAnENCMGFVw+NS5XBO0A/gB2EU
         iuDxta0USipsVVfoAAkMLtzFcK6KVS/fbGoXs3z9L+P+DDeJBbhoBqP7zFy06fiRNlvj
         wQdRhWpYhJk9dx3L1zLQih3DLpDjWCfHAe3046m2Eayel3STDyF9Lfl8w67FXOXSioXi
         paZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=BvabUkO3PLx1bZnAqoYpXYM9Bgtuk0OU4X8sitVluP0=;
        b=kJmyjD6OC0cv09VDY++0O0mkvWC2MQEnKPVSUl/9zN5HZHrusHZIkdHEzlXiw+NjoH
         D2EjnBxa59QgJ9E2uYPK5vrPT6x0K+vjjvXFav1pE9j8I2Eqnrq2r4L8nuFPKHwLfZ9o
         HpO2vkYkfBBDwt3j3EttTxGUuJLH7yf2pIfzH7fDLThIHO8PJ8iAq0qugaqEeg2Gfndn
         ecIOhZ6EgPQbB8a9v2Alo3z22F7kVVuiMdzvdiHMVucjTAEG9+tjs6xLL6BorDEdpVdH
         ThINsSpRSERlYTVA7F3Ordy/6sAg0P9AcrV8C4PCuopa2CeiYUAgusfiBpBSSKGqF2ld
         obxA==
X-Gm-Message-State: AOAM532Q7u8Gbo0ps9YUGOvHbRQ9R+OsWmToTxkm40oXhm8sth8sYElB
        b/f6+atPbZ3e1SJXx24ym1c=
X-Google-Smtp-Source: ABdhPJy9ApE6c3SfbqY2Hb/7VscmbRDRNUgUxAl4RXloWp+RA9IDhfc4+EvplW8CdB+4FbDKQ9gV+g==
X-Received: by 2002:a05:6a00:a83:b029:1ed:55fc:e22a with SMTP id b3-20020a056a000a83b02901ed55fce22amr19431990pfl.45.1616381566090;
        Sun, 21 Mar 2021 19:52:46 -0700 (PDT)
Received: from localhost ([58.84.78.96])
        by smtp.gmail.com with ESMTPSA id f14sm12396837pfk.92.2021.03.21.19.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 19:52:45 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:52:40 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 01/25] mm: Introduce struct folio
To:     Balbir Singh <bsingharora@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210305041901.2396498-1-willy@infradead.org>
        <20210305041901.2396498-2-willy@infradead.org>
        <20210318235645.GB3346@balbir-desktop>
        <20210319012527.GX3420@casper.infradead.org>
In-Reply-To: <20210319012527.GX3420@casper.infradead.org>
MIME-Version: 1.0
Message-Id: <1616381339.fjexi9aqhl.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Excerpts from Matthew Wilcox's message of March 19, 2021 11:25 am:
> On Fri, Mar 19, 2021 at 10:56:45AM +1100, Balbir Singh wrote:
>> On Fri, Mar 05, 2021 at 04:18:37AM +0000, Matthew Wilcox (Oracle) wrote:
>> > A struct folio refers to an entire (possibly compound) page.  A functi=
on
>> > which takes a struct folio argument declares that it will operate on t=
he
>> > entire compound page, not just PAGE_SIZE bytes.  In return, the caller
>> > guarantees that the pointer it is passing does not point to a tail pag=
e.
>> >
>>=20
>> Is this a part of a larger use case or general cleanup/refactor where
>> the split between page and folio simplify programming?
>=20
> The goal here is to manage memory in larger chunks.  Pages are now too
> small for just about every workload.  Even compiling the kernel sees a 7%
> performance improvement just by doing readahead using relatively small
> THPs (16k-256k).  You can see that work here:
> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/m=
aster

The 7% improvement comes from cache cold kbuild by improving IO
patterns?

Just wondering what kind of readahead is enabled by this that can't
be done with base page size.

Thanks,
Nick
