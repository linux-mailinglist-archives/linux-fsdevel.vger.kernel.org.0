Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C464B7E19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 04:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344016AbiBPDHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 22:07:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbiBPDHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:07:46 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160C389CE1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 19:07:35 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id v22so267317pgb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 19:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P9/Lk8R9pgWnqbRmfZpLv8rIV8QLRWoWxnW3fVXtRwE=;
        b=RjnWgBK3XxvHo1Ay307j23W4JXT8TQPb6hFj1WWQgILnQS7eNKyQJMgEQ6MLGRjAzj
         cpqvAdt+bRfmKxd2DMH2g0nEh4hNCtehFduXIxofrgjg6XoPyqie6JVJuGc1MwQ5FkKI
         vmmOSY3GV3EVOA3OvdM8QxeOACAgAA4LGqIKnt+1GSczjtHj0DbM4sVL5lw7x7wHBwqx
         aMLJxUTbyj4KVMLw1zlUpdMjfp7ja2OO7yQ/Jy282kLaAMeBRPnvRuX3YD8ossHmvqj6
         LEo8NXJTAA3SH1oXxW8qlPplpv+ntEO9ZTnRtiKwaCep2YtJRw9ai5tMBqHpb+EaQDGy
         D3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P9/Lk8R9pgWnqbRmfZpLv8rIV8QLRWoWxnW3fVXtRwE=;
        b=QVJRy5p3XPeeu0gSVooJbKzRx/kWmcdZfYM83lDafuKwVm1PIZRnrAjgX0UP39ThP+
         nsOhDAB8wDOcAANxZipXBJyRGFjL4cTB8m34D9vJp8m90PmOWGRNjZQ/El++BPAc3kuL
         79YdHO3it4UbIH4vEw5oLvaT8PdxW+b5o1900bnbKLNIMowY7Lg+OMaQCxwiWA5bfeY7
         sZWZDdC8/m5APxcfKWD0SkX8kRNHJdJluF75ghzS7IofxG7f7puVN66kIb3OmOmIJMT2
         fhtY9VQSswrsvpENm7+3QxbaC2uMczAdNft2bne5DlDgW6yPTCcwsMx+vkOlvX+2rc5k
         Mj4g==
X-Gm-Message-State: AOAM533U3rgt6cq9PfbE3LRLGtWQYiV122uPV7mWvy1fZLf8HuTOO151
        Tyl91Ui04kQm1VmUHcg69JLrPoQzJ+WCrEAUdzhmkw==
X-Google-Smtp-Source: ABdhPJwioc71Su+pBYx92WbiFVK2Wl/VnCTsrwfw9Z4vHbt8YGMFcSnoFePXywDRU7BA1BW3xC9QPBtHePBtQF6vDk8=
X-Received: by 2002:a05:6a00:b4e:b0:4e1:9986:a5b6 with SMTP id
 p14-20020a056a000b4e00b004e19986a5b6mr139822pfo.61.1644980854632; Tue, 15 Feb
 2022 19:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
 <20220127124058.1172422-6-ruansy.fnst@fujitsu.com> <CAPcyv4jWuWWWBAEesMorK+LL6GVyqf-=VSChdw6P8txtckC=aw@mail.gmail.com>
 <905fd72a-d551-4623-f448-89010b752d0e@fujitsu.com>
In-Reply-To: <905fd72a-d551-4623-f448-89010b752d0e@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Feb 2022 19:07:23 -0800
Message-ID: <CAPcyv4hqq0rV24rp-ewRKqXmLwMamW4ROwcX-NQEZ8i3bADC5g@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] fsdax: Introduce dax_load_page()
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 15, 2022 at 7:02 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrot=
e:
>
>
>
> =E5=9C=A8 2022/2/16 9:34, Dan Williams =E5=86=99=E9=81=93:
> > On Thu, Jan 27, 2022 at 4:41 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> =
wrote:
> >>
> >> The current dax_lock_page() locks dax entry by obtaining mapping and
> >> index in page.  To support 1-to-N RMAP in NVDIMM, we need a new functi=
on
> >> to lock a specific dax entry
> >
> > I do not see a call to dax_lock_entry() in this function, what keeps
> > this lookup valid after xas_unlock_irq()?
>
> I am not sure if I understood your advice correctly:  You said
> dax_lock_entry() is not necessary in v9[1].  So, I deleted it.
>
> [1]:
> https://lore.kernel.org/linux-xfs/CAPcyv4jVDfpHb1DCW+NLXH2YBgLghCVy8o6wrc=
02CXx4g-Bv7Q@mail.gmail.com/

I also said, "if the filesystem can make those guarantees" it was not
clear whether this helper is being called back from an FS context that
guarantees those associations or not. As far as I can see there is
nothing that protects that association. Apologies for the confusion, I
was misunderstanding where the protection was being enforced in this
case.
