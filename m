Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DC83E4C7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhHIS5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 14:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbhHIS5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:57:02 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44F1C0613D3;
        Mon,  9 Aug 2021 11:56:41 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h1so28798571iol.9;
        Mon, 09 Aug 2021 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpaU+dGx63Twhkj2mgwC+GFyqAsKgN0ZWlxIu6Y5jqY=;
        b=OJPZrhQTjHql535iPfgVVBClk63cKVbEh8jUlh4GcGfxX/orw3bDg7p5Xbyo0czO0i
         K6Sl9iT99rS8rJGmu9ms9/utCrtZQS3mmZ9iY3j6vbD65kwmaZ/MdiQUIZz+bOTR87L1
         qSAeZd35g8E8u/7z//VH80+nJGoTkb47gTQ/ruBAnYL3FrRsk3YyreRtU5L2cFLB1sHo
         xid7p6SgVJDYuI4+YTWZykxbThr/wgNue7BZ9NA/nu1VU/LdUYaMvA0DmQldrHxtamA8
         /8jyVb04ncwzN84eAFw4Nhpt55rafhMYUDzpmuDpXHDdJ71qz/wVsQHIJJjPmUfbJ2bM
         ZP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpaU+dGx63Twhkj2mgwC+GFyqAsKgN0ZWlxIu6Y5jqY=;
        b=dwPg9WhVUkjXUI32oKMnAafwXVLk0xC5s03Y0t7gPWKwuY7+Yi9xJn3YB2Un1vLi5/
         +RoeQreMojQ7GZou5m+O4YqPomKjchJ2EqeqDWcWRERjDGHeWnBR06KW55FTAqowPrZn
         PkBP1irnFjl/eR7Tcubhu7aLoylQm1XhGP7L4SMF5Gp/HtwfYyigRSX15jcFwGNGXouH
         osVBZwa+Tu1FrePumflmUr+qcTUlRQVuAiMR6WGD9hJOUfCyKuXL/DCfIwtjMV4E1I/x
         PigtP9FM+enob25kVnCpNGV2JDwiYsrMEFzi8+/w3yNRuFYoRia15cGiwJfCcN7uOaNV
         /6NQ==
X-Gm-Message-State: AOAM530M0DB8GxAeArqZvyAbmDhWsxN7O0d2WjrB9d335tUDtHKRp2eX
        98p54uKjmmQTaH/kj2qBUws7X2E+wY1L9upY+hY=
X-Google-Smtp-Source: ABdhPJwrKjLI1YC00YC1aQ2xOe8GNB8pr0ud9Ef9/Hknw9Cjlw0oZ8BngSgPAHbVLp9oSjdsgbTOMKt6AMD1GpY983w=
X-Received: by 2002:a02:b799:: with SMTP id f25mr23765211jam.143.1628535401210;
 Mon, 09 Aug 2021 11:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-11-almaz.alexandrovich@paragon-software.com>
 <20210809105652.GK5047@twin.jikos.cz> <918ff89414fa49f8bcb2dfd00a7b0f0b@paragon-software.com>
 <20210809164425.rcxtftvb2dq644k5@kari-VirtualBox> <305bdb56-d40f-2774-12fe-5113f15df5c6@infradead.org>
In-Reply-To: <305bdb56-d40f-2774-12fe-5113f15df5c6@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 9 Aug 2021 11:56:30 -0700
Message-ID: <CAA9_cmeK==ZS1wdiOM70L-=z9vQWHiwReS103RfDbCs8weaAzw@mail.gmail.com>
Subject: Re: [PATCH v27 10/10] fs/ntfs3: Add MAINTAINERS
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 9, 2021 at 9:58 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 8/9/21 9:44 AM, Kari Argillander wrote:
> > On Mon, Aug 09, 2021 at 04:16:32PM +0000, Konstantin Komarov wrote:
> >> From: David Sterba <dsterba@suse.cz>
> >> Sent: Monday, August 9, 2021 1:57 PM
> >>> On Thu, Jul 29, 2021 at 04:49:43PM +0300, Konstantin Komarov wrote:
> >>>> This adds MAINTAINERS
> >>>>
> >>>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> >>>> ---
> >>>>   MAINTAINERS | 7 +++++++
> >>>>   1 file changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>> index 9c3428380..3b6b48537 100644
> >>>> --- a/MAINTAINERS
> >>>> +++ b/MAINTAINERS
> >>>> @@ -13279,6 +13279,13 @@ T:        git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
> >>>>   F:       Documentation/filesystems/ntfs.rst
> >>>>   F:       fs/ntfs/
> >>>>
> >>>> +NTFS3 FILESYSTEM
> >>>> +M:        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> >>>> +S:        Supported
> >>>> +W:        http://www.paragon-software.com/
> >>>> +F:        Documentation/filesystems/ntfs3.rst
> >>>> +F:        fs/ntfs3/
> >>>
> >>> Can you please add a git tree and mailing list entries?
> >
> >> Hi David, I'll add the git tree link for the sources to MAINTAINERS in the next patch. As for the mailing list,
> >> apologies for the newbie question here, but will it possible to have the @vger.kernel.org list for the ntfs3,
> >> or it must be external for our case?
> >> Thanks!
> >
> > Good question and I also do not have absolute truth about it but I try
> > to help. It should be possible. I think you can request new list from
> > postmaster@vger.kernel.org
> >
> > If you need public git tree then kernel.org can maybe provide that. They
> > also host ntfs so I think no problem with ntfs3. This way you self
> > do not have to worry public list. But I'm not sure how strict is now
> > days get account. But if you say that it would be nice that you need
> > kernel git then maybe someone can help with that.
> > See more info https://www.kernel.org/faq.html
>
> If postmaster@vger.kernel.org isn't helpful or you just want to use
> kernel.org (note that vger.kernel.org isn't part of kernel.org),
> you can contact: helpdesk@kernel.org  for git tree or mailing list
> requests.  Wherever you have a mailing list, you probably should
> have it archived at lore.kernel.org (see next URL for that).
>
> Also you may want to read  https://korg.wiki.kernel.org

There is also lists.linux.dev for kernel development focused lists:

https://subspace.kernel.org/lists.linux.dev.html
