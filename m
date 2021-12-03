Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39E4467D02
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 19:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382349AbhLCSPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 13:15:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234979AbhLCSPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638555131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OVm0OT3iBmxonhyx3ujuxwBXaBB+Vd0lpl9c1C741QI=;
        b=SDGIAOVsTgpouyQCGSUEeUTY3TLazJ+oIUCvgwXu4TJrrGXaFyQRzA5bKyDu5x0J+Tf9Jx
        U+t1lIhN6LwPO7/e6VqBShTXdYXe253O6fAP2/DxQBwpCcn14xTJsqosUpkIIktknP6vgD
        YyE8y8FsVKnlU9hj9doEgMm07rSqVjo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-fqbI0wj_OtGHtQqW3JBHug-1; Fri, 03 Dec 2021 13:12:10 -0500
X-MC-Unique: fqbI0wj_OtGHtQqW3JBHug-1
Received: by mail-wm1-f70.google.com with SMTP id 201-20020a1c04d2000000b003335bf8075fso1920153wme.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Dec 2021 10:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVm0OT3iBmxonhyx3ujuxwBXaBB+Vd0lpl9c1C741QI=;
        b=dxuiz33SFsP86tnB7V5OIlrlW2tdl52H9OTU+dZAUvMdL96G7wRxVkX/NfrvoGLDHm
         M0ATPHeGkn2mpoicjGbY2/OSQEhp/JX4LxsFLk9lwzzU583F+6eaHdnMdZy8oCKfgtfb
         pWWDJZupM+q22QCSz1cThC8iUqKhLFUt/tHR2lcp1H42Hq1RC5OPnAuHuqJp9KmcBpTe
         6kXHimrcCE/TSWWIHdxXMXYa93+uXURadH/2vOoc37DypFjSxQLtGv9yvCOpYPMNf0rW
         EeoPjfONl2bjtHiyso17wB5WVeDO2YP5YYTmaQOTxjb5Kl69+uZwuPqo35TUXDdoFsxi
         pb6w==
X-Gm-Message-State: AOAM533s0rv7L5nN2pyMkYUHDlUQlax1XssmRj5hDuViHHQ8HGUaI767
        jbozI5E3hy9BjRqTOwspEYc1qVyvsmeYGA/C/6rPA0n5ck5DP5M/06QQERq/DEtR50w72b7Pekn
        KVR+iRpD5B+NqAFAwsTBjUl2bOVtSl4UzZo1Lcj2F0g==
X-Received: by 2002:a1c:f005:: with SMTP id a5mr17543373wmb.19.1638555129468;
        Fri, 03 Dec 2021 10:12:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQR6sbSMWp+wr1XbwmFPvbhovhVed+t90DxqkiD9Bo9uH//esaslD4B3M/FOP3e48MFHRzNCb7WdlY5ZTcAIE=
X-Received: by 2002:a1c:f005:: with SMTP id a5mr17543328wmb.19.1638555129216;
 Fri, 03 Dec 2021 10:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20211201193750.2097885-1-catalin.marinas@arm.com>
 <CAHc6FU7gXfZk7=Xj+RjxCqkmsrcAhenfbeoqa4AmHd5+vgja7g@mail.gmail.com> <CAHk-=wiQAQTGdMNLCKwgnt4EiAXf7Bm6p7NQx5-31S9-qPD8jg@mail.gmail.com>
In-Reply-To: <CAHk-=wiQAQTGdMNLCKwgnt4EiAXf7Bm6p7NQx5-31S9-qPD8jg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 3 Dec 2021 19:11:58 +0100
Message-ID: <CAHc6FU6r-CsMHkWzxEm237mV2vZ2O9g_D7BbCPeaA2qX0dpi0g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Avoid live-lock in fault-in+uaccess loops with
 sub-page faults
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 3, 2021 at 6:58 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Dec 3, 2021 at 7:29 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > We're trying pretty hard to handle large I/O requests efficiently at
> > the filesystem level. A small, static upper limit in the fault-in
> > functions has the potential to ruin those efforts. So I'm not a fan of
> > that.
>
> I don't think fault-in should happen under any sane normal circumstances.
>
> Except for low-memory situations, and then you don't want to fault in
> large areas.
>
> Do you really expect to write big areas that the user has never even
> touched? That would be literally insane.
>
> And if the user _has_ touched them, then they'll in in-core. Except
> for the "swapped out" case.
>
> End result: this is purely a correctness issue, not a performance issue.

It happens when you mmap a file and write the mmapped region to
another file, for example. I don't think we want to make filesystems
go bonkers in such scenarios. Scaling down in response to memory
pressure sounds perfectly fine though.

Thanks,
Andreas

