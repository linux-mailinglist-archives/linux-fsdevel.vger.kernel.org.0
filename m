Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F194D5276
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 20:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbiCJStG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 13:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiCJStF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:49:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC07C377EE
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 10:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646938082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IAMDDR/OlT3VUgZyoMb3yfhymErEdiK+nlypftXgzIc=;
        b=EC77DK2kCivl92+punPKvbL2aqH5ZUEKkBJ+0sxrqfGbzDEAGHScS2d/qPdrbTNZ6nJWms
        fuVccIgNv3U43wx96rlwu1RgDmQXEsqJJRz9Nv4exhFY/Pqr88l7wuGKeClR11MNTpxUtZ
        qsRn1dQjdnddRfg/VT5D63OJTfcWCCU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-rbIta8bwOJ6p52Sz0sXpMA-1; Thu, 10 Mar 2022 13:48:01 -0500
X-MC-Unique: rbIta8bwOJ6p52Sz0sXpMA-1
Received: by mail-wm1-f71.google.com with SMTP id a26-20020a7bc1da000000b003857205ec7cso2638625wmj.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 10:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAMDDR/OlT3VUgZyoMb3yfhymErEdiK+nlypftXgzIc=;
        b=VeujMNyqN3tfLzWWF9/MDppr5t02IbS7eA2FwmNEDE33PJvnrAPfmZmG848BSD7k1i
         XMgS+VBoxffKSsE7R76E9AL2lhOqrDfw6Usf3ChhkIrIQ6MMMaHQYT3X9k2crna/M+4R
         Dx1vGKRsWsICeUVz2cuw0yRA9PaaWoAddWSM7YmxOcGWUQn/UeQwpWQXZIsiGfPP2PTa
         ECXI7DZHvmboe7rRjh09j26h0N13bUsLQNs8FwL3bQBqTCO9abYnDc9kZhB+n2cskzD4
         ojfm81iXaET6RhpeRyadWAc89N8jYJGx80lXpw2ef87vBMET1Op71Jglu6zAtt5fzIzB
         pwHA==
X-Gm-Message-State: AOAM530XSUDiyDunYBsXoYYxztgh8mU4fAdZsRZOCrqzlPzDKJL7Qdl4
        NhORhuTposevm7TwzpXqabIqQFkcGep/uJ9KBOx6t36TnANYemr728nG2+E5HHXuu8ca0ExUZAF
        tISrU4Etuv0uTYOOXLQQ988sFJdon4CV+08JSU5HwlA==
X-Received: by 2002:a05:6000:154b:b0:203:7564:930 with SMTP id 11-20020a056000154b00b0020375640930mr4625769wry.349.1646938080537;
        Thu, 10 Mar 2022 10:48:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1y1c4l/wYGkW+ggwZo6uKhbBm9y9Jr+TggF7K0Kz6yMLtKELmt+rxnEHc+KJK41kda9Lif0f87yrE0QOxUj8=
X-Received: by 2002:a05:6000:154b:b0:203:7564:930 with SMTP id
 11-20020a056000154b00b0020375640930mr4625762wry.349.1646938080321; Thu, 10
 Mar 2022 10:48:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com> <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 10 Mar 2022 19:47:48 +0100
Message-ID: <CAHc6FU6+y2ZGg3QnW9NLsj43vvDpAFu-pVBK-xTPfsDcKa39Mg@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 7:36 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Mar 10, 2022 at 9:13 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > For the time being, the idea LGTM.
>
> I'll take that as an acked-by, and I think I'll just commit it to my
> real tree rather than delay this fix for the next merge window (only
> to have it then be marked as stable and applied that wat).

Works for me. This should probably still be tagged as:

Fixes: cdd591fc86e3 ("iov_iter: Introduce fault_in_iov_iter_writeable")
Cc: stable@vger.kernel.org # v5.16+

Thanks,
Andreas

