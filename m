Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575A23F0D11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 23:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhHRVCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 17:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbhHRVCB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 17:02:01 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA23C0613CF
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 14:01:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 17so3612884pgp.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tsxhBVRZlO9and7DhCBUruAlzXa20bXVaKImjY48c7o=;
        b=zGGJKW23TpE7PPFJ4/n391OFSE+ePfB6XhKYr42xqQdacaGLoy/MLGcJOB9KJclibB
         29yQ1DLoZOq7YUGzImZJ1hjNXdcN4bUgBPPOpNCAUpQuExc321UUpjfAEZalmz/yrEmp
         QMBCgYswdRECqSZZszyKnB1/zOj6k9++ko8k9sPqN4YI0mQ+MpWE8w90ykG4GHsvonXj
         +NKnoDJPWaGnOUjnABohDzuGK/EN0y6cm+wAyrcNscAwRna0z/xgPtNqS+mR4HhFrKCd
         yR/73F6u/b1hWv+BHa6yM7WRf5HOfuotX6pcWtI2uqTJ6KkhqyfixiY4MEVxCLYod6oS
         Jj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsxhBVRZlO9and7DhCBUruAlzXa20bXVaKImjY48c7o=;
        b=HpeHQDk15SRfpezomiA3bFHXbBLqyrIzpsEz8XqPoeXdsnbQ55aKbnaP1ZqT3PsvhA
         jNQm/pwhP1eK6DM4IF2tYbAoittVG2sOK+cCX9KNhZ2eNxTSjEkw2QVL4AqXMHTUD1oH
         btB2VPm5K5iBLf3/zTZ0XsIITH7arEq0ansvuuWHaw6F0I+tSZjKirjtUZO/ek09p8ff
         /mTu7xnQv5IyHABp4xmVjG7Rprek9EbBg8NSUWWO7hv6KM431LWBgl0YqyKGAo/Xf3zB
         uNSIIl9w95xh5rA9Tp5HX2mlkAUoKz8yhJQnM85VoariNiPfT1MkuyfVGiu6dT3Yg+qq
         5ieg==
X-Gm-Message-State: AOAM533tTYKQal7DjC8UF0RVr74H9FZ+nopLvTazi2Onx3aU9Rg6YBmo
        jww4zfOXyHJO6bGPC9WQSrQrmEer5rjgM1XSydeCxA==
X-Google-Smtp-Source: ABdhPJyC7TVzou7MS10S9DHd4c6rf2rdDWgmDabraG+KHQy+8QVQinJv59B8c4LqBnwh3oILNYKei6BontbTyhivPwk=
X-Received: by 2002:a63:dd0e:: with SMTP id t14mr9090412pgg.279.1629320486279;
 Wed, 18 Aug 2021 14:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com> <20210816060359.1442450-2-ruansy.fnst@fujitsu.com>
In-Reply-To: <20210816060359.1442450-2-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Aug 2021 14:01:15 -0700
Message-ID: <CAPcyv4jUDGDK5nXiVhEgw_Pwkjf8D=O4Nbw0Gd1YdWUJEoifpQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] fsdax: Output address in dax_iomap_pfn() and
 rename it
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 15, 2021 at 11:04 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> Add address output in dax_iomap_pfn() in order to perform a memcpy() in
> CoW case.  Since this function both output address and pfn, rename it to
> dax_iomap_direct_access().
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
