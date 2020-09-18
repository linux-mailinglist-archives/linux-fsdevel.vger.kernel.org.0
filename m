Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37502701E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 18:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIRQQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 12:16:13 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:37495 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgIRQQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:16:12 -0400
Received: by mail-lf1-f42.google.com with SMTP id z19so6735029lfr.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2020 09:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dn4foQaoHNSvTBAsvN4xy761rYCwhgHIbxdKsKpeVMM=;
        b=LMdE4OWFexmH87rYgNhPJoFtRZUTMvjzvdlyfZAFsTPAAyq+K2L+hDg4e9tEg0TX/e
         gMG7IRHx14WRWf4gO712no9xFYzCQ5OWLPIMeTo1ezYyG9b+Rt3f7PBxw4AzHwjMV+gg
         AYVFAdBva2zn5Ozp8is0Z5KvEPvwr5chF9PM/nmjsbepyjcgT/+LAbWvnG0zTngseomD
         9kz1rpcVy9o5XW81sYo/wO1mpt31YqejkI3tU5qHOQzeEQ5Ok8ZLq5LqUfd+aLFmd/S5
         J4pEFEpDm4iCMmMd7SBthIchxZ+dfG/tsiD0AbFd6NsFXvj9mPA+vFVrZlBi8+Yh1lxh
         /dMw==
X-Gm-Message-State: AOAM530kIleGcdnAib/iwerc5rktnnrsSEN8j2lPMn5fTic+sFZhhTaT
        9mrcFBU7QUuiAdmpSb5Pfgo=
X-Google-Smtp-Source: ABdhPJye3WI95GI41cqwNYID7/3EzuGyhDLvR+HfCyBgJ+MwbZyf6NLDvcSmA5ZtFe04iY8foM4DDg==
X-Received: by 2002:a19:c804:: with SMTP id y4mr10459371lff.367.1600445770724;
        Fri, 18 Sep 2020 09:16:10 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u27sm666454lfg.233.2020.09.18.09.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 09:16:10 -0700 (PDT)
Date:   Fri, 18 Sep 2020 18:16:09 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] fs: Remove duplicated flag O_NDELAY occurring twice
 in VALID_OPEN_FLAGS
Message-ID: <20200918161609.GA50447@rocinante>
References: <20200906223949.62771-1-kw@linux.com>
 <20200916193500.GA25498@rocinante>
 <20200916232808.GN3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200916232808.GN3421308@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Al,

On 20-09-17 00:28:08, Al Viro wrote:
[...]
> In #work.misc, will be in -next shortly.

Thank you!

Krzysztof
