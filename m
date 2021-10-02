Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F5841FA60
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Oct 2021 09:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhJBIAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Oct 2021 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbhJBIAB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Oct 2021 04:00:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEAEC061775;
        Sat,  2 Oct 2021 00:58:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g7so42213742edv.1;
        Sat, 02 Oct 2021 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ts6bk3GxBovwG4f530eMKfVDJOqsxZjiK9yVTc/q2vI=;
        b=ixui5CDxltu462nt8n7kRhhiVQESIcKesNwemS7JvZkqIURGjUXuzSMSmnvdfhYudH
         f3T+wWOeY9eMpdqz4vYcC1E7uPhojBm+ccJxF4NMJKsoYO7nGmWJD2WogIm0HV4so02Y
         xIlMHFK6UaGngR/CQvYrDC9Z8LMDEYBDqXfHF8znpRpRZ/7NxqefphOF4/zFnpIleZJU
         GykbYp+YtLnjjPMaO4iUXin5hGEYe2kg9mdrHxI0nH8tpM07QifJVMCV7h9qJzxbdGwy
         EbaGZKCPrHChqqHWOyOouKJc4YQjwLzTFHlfTjSkcsgT722SE30U0ZB9A5XC9Atwc7DY
         V3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ts6bk3GxBovwG4f530eMKfVDJOqsxZjiK9yVTc/q2vI=;
        b=ECmx+gjM4BLHREUzQ8KVVjUFY4FZXgC4k922cG8p13On2v77K1mFv2q+Z8XbMwJeDr
         Ma4DD2/PWyWNK43dbcDXLDEMjs2jJiBPkOdqqPGVWckj0K8VTxefOBN1OOpkFrdVaKCJ
         8MYVahapvVoFeOOxbgjjZZTEGgG9+2G8yJLy930Z/1dEj2N186BXmtf8dRUiMfAjP9Ct
         aB5wmtLigzzfztYi5koiho0T9zX5GxSZLoGYUAymF42FLK5lS86k6ak4NqJnzKiSlELl
         RHgX64YVojXSt4K01TibghQ8a212EGDfjNBpJTJ4VXojUOcC/bgnbIgizTc4skXyHpSZ
         v8Ug==
X-Gm-Message-State: AOAM530Ju1JvKn0tnL5su70iWH8h7DRjDMD95WWKb6SkUL2ahchSlUdw
        e0RGYSfjJAefumMJqIaV2QqWufEbVHK9o6Rzj/+IflP1ako=
X-Google-Smtp-Source: ABdhPJxCmLx4wUpcKCRgAg9IvaHgwZ17hJLPvVRKzijZAVUEVTSIPDE7KPW8qbpn/1SO3pcTcGQ+dDHuMJhQYaadV4s=
X-Received: by 2002:a50:e00b:: with SMTP id e11mr2498592edl.359.1633161494719;
 Sat, 02 Oct 2021 00:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211001122917.67228-1-andriy.shevchenko@linux.intel.com> <20211001163931.e3bb7bf5a401fa982fda5bb2@linux-foundation.org>
In-Reply-To: <20211001163931.e3bb7bf5a401fa982fda5bb2@linux-foundation.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 2 Oct 2021 10:57:38 +0300
Message-ID: <CAHp75VdQeNnNqVtp00iD6Wo+5GOs1AxSKqSDmxxx6D-AbAJ2AQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] seq_file: Move seq_escape() to a header
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 2, 2021 at 2:41 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri,  1 Oct 2021 15:29:17 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > Move seq_escape() to the header as inliner.
>
> Some reason for doing this would be nice.  Does it make the kernel
> smaller?  Is this performance-sensitive?

It reduces exported namespace, hence makes it smaller, yes.

...

> > +#include <linux/string_helpers.h>
>
> Why was this added?

The definition of ESCAPE_OCTAL is there.

-- 
With Best Regards,
Andy Shevchenko
