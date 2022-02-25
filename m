Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6104C47E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 15:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241875AbiBYOxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 09:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241692AbiBYOxR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:53:17 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AE115C19B
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 06:52:43 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso6420008ooc.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 06:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2d2A3E72PD4ZnjabW+/j5KRYHuTUGB4Rh6qEh1bQ3A=;
        b=ur2Nfp90lT1ydsXWMkenY5yHfHVTztxJufFT1E+koLOkEssCbmJ06s7vYDP5a1+p2C
         JDHLdR2LENeUqO6Vine8jrH6I/tOS9mtl/Cw8hlGp58OIcixbS2i5UFL4lnxfIDAVfTP
         OtCkc+ZQHyxHaQDjuFLXlKE0NBHxoSfTVuh9KYZWoaCXDgJdEMCxqO7vtHhLoaaf1sFh
         qNi4120K4kcIUV2t9KjXsqz1fC123Z1+48QMzHUpiH1UM8wDeeYkyF0qP55H39MpUflM
         G3ZJK2/FWuLzlk43043E7JFWCpSKTM9z5JdPdd/U+0MG9UTx8yhSY+zYbIoJ9LhMRKMp
         CMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2d2A3E72PD4ZnjabW+/j5KRYHuTUGB4Rh6qEh1bQ3A=;
        b=Q/dS8ZtoA1QGWxHUz3TnVKmzqpXF5e2JIB9oQeEsn5peOuHrghvbzBX29vAl8czblh
         saC9PNGemupva6Le5MzmhiUWPj7r7TWAUKB2voOAbu0IG61ehlGhziN7hJSlXNhsIX1F
         wez3wK26y2Emuh79NZZiuI7sA6tLYheP/U7ldjFj8H503PHmLdjjI6b9Uww/bepp/qG8
         UgcxcNDsV5lygW9NeyDjY4U0kd1kMS2AngpwFEF8hfCfBBJIhNbEo6N6Yn/31CsjVZ4u
         TXOqCKcCQvgpTR8MnDuFe2VrLvmlIbuHD/DoH6jrc+lJZLY8qXJSI2uD6KdRQR+xrEXR
         Ri/g==
X-Gm-Message-State: AOAM532MQocQXph9HlFPn9eNdXsWSOsolAvko1guBFA1YinwPGFSJSTo
        2nr0ORv0nKnOnbxLn1TttXO0PZ1Sua8e1GXWPGJj4jyN4VKqrw==
X-Google-Smtp-Source: ABdhPJzc5dvcEURQPm0a1Ibexp5oDfoNr4t66Ygj1rEyK50ERTcjVz6Usb1B/GLRuwGhvsG8vdGASGuyKPAqPfIjLW4=
X-Received: by 2002:a05:6870:e2d5:b0:d6:d26e:855e with SMTP id
 w21-20020a056870e2d500b000d6d26e855emr1430549oad.269.1645800762694; Fri, 25
 Feb 2022 06:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20220209202215.2055748-1-willy@infradead.org> <Ygpk+ys4SOu6uTrN@casper.infradead.org>
In-Reply-To: <Ygpk+ys4SOu6uTrN@casper.infradead.org>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Fri, 25 Feb 2022 09:52:31 -0500
Message-ID: <CAOg9mSRzb_7Juse=-rAs1Pxqtvfi5o-LOdzOwu9BAQPHwoo=NQ@mail.gmail.com>
Subject: Re: [PATCH 00/56] Filesystem folio conversions for 5.18
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I tested for orangefs on top of Linux 5.17-rc4 and found it to be good...

I did my testing inside of gcloud instead of on my wimpy VMs for the
first time, it was interesting and fast :-) ...

-Mike

On Mon, Feb 14, 2022 at 9:19 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Feb 09, 2022 at 08:21:19PM +0000, Matthew Wilcox (Oracle) wrote:
> > As I threatened ;-) previously, here are a number of filesystem changes
> > that I'm going to try to push into 5.18.
> >
> > Trond's going to take the first two through the NFS tree, so I'll drop
> > them as soon as they appear in -next.  I should probably send patches 3
> > and 6 as bugfixes before 5.18.  Review & testing appreciated.  This is
> > all against current Linus tree as of today.  xfstests running now against
> > xfs, with a root of ext4, so that's at least partially tested.  I probably
> > shan't do detailed testing of any of the filesystems I modified here since
> > it's pretty much all mechanical.
>
> I've been asked if I pushed this to git anywhere; I hadn't, but
> here it is:
>
> git://git.infradead.org/users/willy/pagecache.git fs-folio
> or on the web:
> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/fs-folio
>
