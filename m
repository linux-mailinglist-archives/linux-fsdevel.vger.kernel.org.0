Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1686D30B43C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 01:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhBBAl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 19:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhBBAl2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:41:28 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74716C061573
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Feb 2021 16:40:48 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id d1so18213810otl.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 16:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=512mD1piClNGqa7trrAyoZ6mfS/JdiUML6oInKasp/Q=;
        b=rXKYy+BVbsJn0jv0B8wOdMKV7CKKu2vhKULSDl2P1mwB0PsVqy3yskIu/9mYdG0Hqc
         qXyi82DDJpCNp3wX5xL3pEI9379udtTsjyiucdVTaG3KUO186Ql5w4NnFZmQ2ywN9FEw
         edT2t33ah9OEe/bK3yHqcr3rN76dcs2qzcyENBbqhCptNelQotlIHoEzmV96t8/DBA1T
         rVVUfqfk5+Je+j6KfSrVMetSn1nSdkIY1WrtsEZBGqTd82p4H1ITKvLLIUSyXibPs1sU
         Jhb1LjGR3RVajrhk4mPThyLeXXTzNMso7GCitKr0W/ZYFzKp3fFqAZkwoPOONW/WYwlP
         D24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=512mD1piClNGqa7trrAyoZ6mfS/JdiUML6oInKasp/Q=;
        b=e7hjbQ11olEQZSzrZh2QYcEQRv3bmZ8WrCY59d2X0+kYNFSvjyefEkLAqbqJBesw2R
         xHgoS/viHQny7uv1CbjFySJDB4NwO7kFD8Q5GemrEZm70BmCOb+/stcWFEugbQxzAE83
         kk6RAYvN3calHGStFqfEkc+mI5gwCWKh5c4IgkwkRju+bWYzWfGZap5poIT9andakFj6
         D9a/5YOOjezc6j2O5PFX0iUbzSFqA8m7hDhy6gFYL4VhiPjX33/yoixch+NGfvJ8fDzg
         xzS1u6ckSchgdlAgD+L3U5hphQlNZB5ot1HSwduB89W/y/T7AxPpnHd/6f9ugSNGmZVC
         KnsA==
X-Gm-Message-State: AOAM533KNfz44ru9dcjHgqMzRHNHFv+1qqZYswoRI7G2BBiIlscYidb/
        InEhKbu85F2ASO02OO8PbgWLjn00H3uy0Qxe3iK9K+FmCvM=
X-Google-Smtp-Source: ABdhPJz1pRr8S/+TQVlFajNScZ+OU8KLWdATQb9OFOCkRiz71dlttVEgJYtm/gJ2kb7BoGh2vaJdEV0A/VmK/6AaJLc=
X-Received: by 2002:a05:6830:15c5:: with SMTP id j5mr13599435otr.185.1612226447845;
 Mon, 01 Feb 2021 16:40:47 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT63RUz0r2LaJZ7hvayzfLadEdsZjymg8UYU481de+6wLA@mail.gmail.com>
 <BYAPR04MB4965DE15FE77E45C46BA2A7986B69@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965DE15FE77E45C46BA2A7986B69@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Mon, 1 Feb 2021 16:40:36 -0800
Message-ID: <CAE1WUT4qkuO8wahYZf4Ff6KEn7OgK1PTMs8WmxxGK-MKqsF=cA@mail.gmail.com>
Subject: Re: Using bit shifts for VXFS file modes
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 1, 2021 at 3:57 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 2/1/21 15:50, Amy Parker wrote:
> > Especially in an expanded form like this, these are ugly to read, and
> > a pain to work with.
> >
> > An example of potentially a better method, from fs/dax.c:
> >
> > #define DAX_SHIFT (4)
> > #define DAX_LOCKED (1UL << 0)
> > #define DAX_PMD (1UL << 1)
> > #define DAX_ZERO_PAGE (1UL << 2)
> > #define DAX_EMPTY (1UL << 3)
> I think this is much better to read with proper alignment.

Yep - on the actual file it is.
