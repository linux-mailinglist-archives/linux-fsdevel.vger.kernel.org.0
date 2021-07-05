Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CFD3BC138
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhGEPyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 11:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231806AbhGEPyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625500296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=94h8HuvsNXIPuzkfFYVmJcfX+faEonOANTvfeqnyEF4=;
        b=JUpWFTtjWzZuJmj2kCNsjR1MOInldBo2sgQPJK9dLAQBMDz4NoXTb1HY2JeFsjzi7SbTi+
        kFKxCQwQlak+muf0mjA2JLInXLLGkHeZhQ+Xznv9AwlfAtJmbz6ToDlImK7zkg8ur1FPK5
        r9tTiDHuXGLSgm8raryTjmabax8tiQg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-Ks4lYaqcNDa02Z3Qkh-VYw-1; Mon, 05 Jul 2021 11:51:34 -0400
X-MC-Unique: Ks4lYaqcNDa02Z3Qkh-VYw-1
Received: by mail-wm1-f70.google.com with SMTP id n17-20020a05600c4f91b0290209ebf81aabso129854wmq.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jul 2021 08:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94h8HuvsNXIPuzkfFYVmJcfX+faEonOANTvfeqnyEF4=;
        b=gKnjzIdh4Rlz1YTv8gWAT0+TOnmzBj/DOK0Kxv9hP5kK0aCRqE64ETLrrZ7k6T6kIK
         59r8sYXCZ5VgUN3vA2OnnAbI+6Udk1kVRI2YjjEi4e0NbRiLytAw2JpY0Q9toZUrlN0n
         TzUJUZ1hEfc5PovfXjtdBHPpGW7s1q7G8gm+PTuiS6T+IF+nV86OKJYwFYfg7sA/O1TJ
         jOsJ1EIosWg5QwnFDJvDRv3B9HNYSW4QcqMCeIU7wY40JXi9VO2ojTRRBVPQYHpQxVW9
         51/jYYzHjjQ+hrN/e1iCdt3K0STJW2yuW7RH2PwQHg2EnobZ9N3Hmtj13QkLWSA01ZJB
         izIA==
X-Gm-Message-State: AOAM530NZFF4QxGR2Yd2Npcsha2nq5kyuryZgyRNv5U/DREBUc0z3FNA
        7Ans1p8Z9KuwYrfwSjxWk1A0RhNOfGLBwjO2krrDte/1R+SzWXUgKAIUjAXgQa2gE35hmoja3fI
        CXSmzdZIsgB2DTqvNZz87b++0WRSHf4jprugN02UjsQ==
X-Received: by 2002:a7b:c40d:: with SMTP id k13mr15673000wmi.97.1625500293822;
        Mon, 05 Jul 2021 08:51:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwt0xgTY8Fc/m6wSLIkQmnvuBGTo0ib6uAwtg1dnYqClFwZpSqUixG70VxfLezXErN7AKL1pIfnEj+ourL3X3M=
X-Received: by 2002:a7b:c40d:: with SMTP id k13mr15672989wmi.97.1625500293712;
 Mon, 05 Jul 2021 08:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210628172727.1894503-1-agruenba@redhat.com> <YNoJPZ4NWiqok/by@casper.infradead.org>
 <YNoLTl602RrckQND@infradead.org> <YNpGW2KNMF9f77bk@casper.infradead.org>
 <YNqvzNd+7+YtXfQj@infradead.org> <CAHc6FU7+Q0D_pnjUbLXseeHfVQZ2nHTKMzH+0ppLh9cpX-UaPg@mail.gmail.com>
In-Reply-To: <CAHc6FU7+Q0D_pnjUbLXseeHfVQZ2nHTKMzH+0ppLh9cpX-UaPg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 5 Jul 2021 17:51:22 +0200
Message-ID: <CAHc6FU6NWgVGPkvLM_mb+TpK3aM2BK+RrLgKgfS20kCLVV=ECg@mail.gmail.com>
Subject: Re: [PATCH 0/2] iomap: small block problems
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 2:29 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> Darrick,
>
> will you pick up those two patches and push them to Linus? They both
> seem pretty safe.

Hello, is there anybody out there?

I've put the two patches here with the sign-offs they've received:

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=for-next.iomap

Thanks,
Andreas

