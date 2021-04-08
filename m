Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9EA358E98
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 22:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhDHUj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 16:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhDHUj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:39:58 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED8C061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 13:39:46 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so3625842otk.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9j1bK2upZfEGn1Vxn178ZxXGrhfiZMKD/Kfu7iKqLJg=;
        b=p1u3s/rifboWAYPJ5jK1hXunVmFJCYeEywcJQchfKfNRjKGfT1bGxsT7dyEhxCfXf1
         IKiW6P4ShyTIr2TVq3DvMVaLzYyg7lUTbuj21HWW6puqK8HhliX+ZPo4NObgcloTV0NU
         pO/ZJkTAcVD9qUCJCCFLWflbyTexHbB17muyOHpdSEqlD3Lxmk9IrFUHDerlBP0RxH6Y
         TTX9Nk8texJfrLupXTL+d4pX3IKyjhXtYnEwQFVu1gIfr6Eh3ODf7TfKVXRgayJon7Pn
         SJR3xbNqPCn2dbAcY+ZFsO5RMrCetzaYyg/qtFrpdRwPSZoaO8qnxQY2XAQ5NF2KawG6
         vjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9j1bK2upZfEGn1Vxn178ZxXGrhfiZMKD/Kfu7iKqLJg=;
        b=dkZgl9QRMZr2Ndea35qovIJcgevFg5DdgSQGarmHQ/YPh6fWbJxJxF2M/nd88PkelW
         fDkYAOOfD7OeEPOW8iKtRtAil19mim+wr13AtZt3DYtMZQ9/VIizWf8Mt6fQzmS1zO9Z
         3an6jNFiTRAIL590gbc3eu5f7pLWnBjcT3Pctd367JlZ1YmEDmnjOUEtqeLGQ8xL5yNC
         d2W74464oS6XkFhxFRI+TSS8u6hJHfb2iwlE2n783cBhmbawyxKBXGp20FWYb7iPYB7F
         IZzv1WVBJCXijUgSZEm1Z7OgKN20d0fqwQW8/v652WjW3A6ShSXY3rs+VBU0UOMTDI4s
         2w3Q==
X-Gm-Message-State: AOAM532Uj1bOAjf+Ua65eYhdmtFUTHbz8QEQVR9b6/XaCU93Hdc3VSV0
        JdJ2BELew328bwUCHuBrhmhIIzpTf8J0O05XQWBGug==
X-Google-Smtp-Source: ABdhPJxi2/8yzbdo0JTgde0doRgSN9ybYO7SC9hnMgp/BTzrcDDkW9EAcSmLhabaifinuGw/7rBnLhd7fr7iEKcWbF0=
X-Received: by 2002:a9d:5d0a:: with SMTP id b10mr9185075oti.180.1617914386326;
 Thu, 08 Apr 2021 13:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210327035019.GG1719932@casper.infradead.org>
 <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
 <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
 <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
 <1507388.1616833898@warthog.procyon.org.uk> <20210327135659.GH1719932@casper.infradead.org>
 <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com>
 <20210327155630.GJ1719932@casper.infradead.org> <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com>
 <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com>
 <1720948.1617010659@warthog.procyon.org.uk> <CAOg9mSTEepP-BjV85dOmk6hbhQXYtz2k1y5G1RbN9boN7Mw3wA@mail.gmail.com>
 <3726695.1617284551@warthog.procyon.org.uk>
In-Reply-To: <3726695.1617284551@warthog.procyon.org.uk>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 8 Apr 2021 16:39:35 -0400
Message-ID: <CAOg9mSQTRfS1Wyd_ULbN8cS7FstH9ix-um9ZeKLa2O=xLgF+-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David... I've been gone on a motorcycle adventure,
sorry for the delay... here's my public branch...

https://github.com/hubcapsc/linux/tree/readahead_v3

-Mike

On Thu, Apr 1, 2021 at 9:42 AM David Howells <dhowells@redhat.com> wrote:
>
> Mike Marshall <hubcap@omnibond.com> wrote:
>
> > I did    git format-patch a38fd874..ff60d1fc
> > and added that to my Linux 5.12-rc4 tree to make my orangefs_readahead
> > patch that uses readahead_expand.
>
> You're using the readahead_expand patch and the iov_iter_xarray patches?
>
> Do you have a public branch I can look at?
>
> David
>
