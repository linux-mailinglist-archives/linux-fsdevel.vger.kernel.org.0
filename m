Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886182D4B90
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 21:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbgLIUUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 15:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgLIUUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:20:42 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93737C0613CF
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 12:20:01 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so3993544ejb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 12:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXNuciZGAoMUd/SECQlzOKmimQYdL/sit6tT9G5FsLo=;
        b=Q4GredAdgUUiXIbnr4HhP9p4y/6aHiGOTj9T+SVRf3kx4jQtzCfwRvKnAkHYEBZcWE
         ee3uqdHPp5k4JKb79Y5S6kmR/D4Q8upV/TIaPHuo+cxp4w8Oydj91Gxcl5tUuo7jtpaC
         KXfE7t6+r2NUrtdhqQE0bu2sWsOhFqtqL0B2CfN8vZnUCOMLZS2YQZ+qAs/dXQ+eYEi7
         +Py9L7vzjcQn5Av1sENWe5rJZydVY3MRfw/QlMLb6QKyq5OhAFqelIG3UrmT6v7vIZId
         kjPTp3aik1B619eE8Q/U0xq5arI3NIWjhKvCG34pgak0WPwVbCwyzsi5BZbPZl63GqaI
         DFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXNuciZGAoMUd/SECQlzOKmimQYdL/sit6tT9G5FsLo=;
        b=WEoWB8zSQqZHVB+ngemFvIxKMO59+6vtWR8CX2zPS4yA6krR4/9eebHey8CFA2Zijm
         FLU8S+k0XQfoeZhms7OG9W8gLmixyQYAuRc6ENxOA7JMiBjxvJFqGemqOqc7vkeUr2nn
         u6UwMlOR1fNMBbQ9oR9gwvjZttJ76ChJy7MWgS9g8VIsrglfmDi0UHdQ1UlHoZ2weJ9i
         Kj9nYmniuUcvKkHZIDiKcSw3hISb6XTqM8aBAnkK1U3dwcb91HLyTbmVyw2iiQvr4hDl
         +fFj2K4eXzsFVj4Yw10lBfwwIsyphciW7CG4T9Yx/3lhbyjmyl2H6s2LDRBb1ld5Ftl/
         8F/g==
X-Gm-Message-State: AOAM530oCRVToIPx3YC1bAsD21b0up1beMMq9N6H4qn98x4pK0BEyBze
        CWPomMCtxpZJ3YmhWU55SDnQ1uUCpKpH8dEIBfChCg==
X-Google-Smtp-Source: ABdhPJyjaG7i4wtncjlxdho8e69LLSxKEMKXMhbjmbkgJwA1jMQgUCys7NV0tdXd1OBOdnz8985W3plWWreMWFhRiwc=
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr3603934ejc.472.1607545200188;
 Wed, 09 Dec 2020 12:20:00 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
 <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com> <20201208215028.GK7338@casper.infradead.org>
 <CAPcyv4irF7YoEjOZ1iOrPPJDsw_-j4kiaqz_6Gf=cz1y3RpdoQ@mail.gmail.com>
 <20201208223234.GL7338@casper.infradead.org> <20201208224555.GA605321@magnolia>
 <CAPcyv4jEmdfAz8foEUtDw4GEm2-+7J-4GULZ=6tCD+9K5CFzRw@mail.gmail.com>
 <20201209022250.GP1563847@iweiny-DESK2.sc.intel.com> <20201209040312.GN7338@casper.infradead.org>
 <CAPcyv4iD0eprWC_kMOdYdX-GvT-72OjZB-CKA9b5qV8BwNQ+6A@mail.gmail.com> <20201209201415.GT7338@casper.infradead.org>
In-Reply-To: <20201209201415.GT7338@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Dec 2020 12:19:57 -0800
Message-ID: <CAPcyv4h6mxo3vOU9r6ZcC1jUL_FCCEjmJ8dfmgYccNVJrGi3hQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 12:14 PM Matthew Wilcox <willy@infradead.org> wrote:
[..]
> If we put in into a separate patch, someone will suggest backing out the
> patch which tells us that there's a problem.  You know, like this guy ...
> https://lore.kernel.org/linux-mm/CAPcyv4jNVroYmirzKw_=CsEixOEACdL3M1Wc4xjd_TFv3h+o8Q@mail.gmail.com/

...and that person, like in this case, will be told 'no' and go on to
find / fix the real problem.
