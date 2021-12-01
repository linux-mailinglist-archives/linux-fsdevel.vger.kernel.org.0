Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8364659C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 00:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbhLAX0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 18:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhLAX0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:26:50 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB842C061574;
        Wed,  1 Dec 2021 15:23:28 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id s11so19965880ilv.3;
        Wed, 01 Dec 2021 15:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Af3RlAsLkBfp1bcElgEIL/uV/0nmFtZn2QzPrICGZJc=;
        b=KTF5cCZkcyKB8kh4XpQbQwXfGXimMLisrHNjl73Lc21ru4fUBu8Zy8O6dZQD6GT1Zj
         +G9Hqk7mmNnS8jKGSbdiN0H9dIZa7u3cQuTsePDq9TbgQ64uUn75+NZqIGA6bkDhckdk
         g9rHEfkp9H1Go0/hhVRryCZt+fVVmSHCgj74H5DGpQpM+oStsgMWIPMWu+Abti0pAxPK
         62ocDpeb8rZvFhpIxhgsyqkxQjFnQyfx7w4qxf/ZZoXy2ZetH1n12RbnB3p1ZcmHtnQ3
         +Q92UdUomWOK8TMs5b6VhuYV643jMH4E3XQrvXENqlK0pEWRLe8chFZWu9GkHd4kV4OP
         zWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Af3RlAsLkBfp1bcElgEIL/uV/0nmFtZn2QzPrICGZJc=;
        b=BINApKAA63FTVqPBPWLMulN/X3nuO98O7N58uznFYGRN1HQ/ozeZuIX8D8KZJnrTFY
         pibUcxL6oR2U7eR3Q0HrbS3yP5BTOmBjrWx2Y8va1ckHR5cfiR9091+E0eljqfGiqtfY
         RrJllWPXNE86lA+oMi0bQ5n7EAyrgaxo7tobuiaEonuP1mkRTF38qqTu+7PdIOJr2a8D
         C87U5J0fv3ccaxA0XJHxTY3ZjPH7JmHZgsb31H/eHr2BUYPGiuy1serGSOUqhhr1bJmL
         UEkHK//csxI2f5m6DHfdmWVAGTxLwTASa/in4k4DLZfzOIhoMSL9VN3Jmz166mZ1nLLC
         kz+g==
X-Gm-Message-State: AOAM530PcS4rfZj8JynS4kjsPzK+fyQl+/uIuYUyriHIlDu0XFKH1v4Y
        NKJs6TdTrMbMDSYP3DCfHGaDGO4PfylxhMiE3MQ=
X-Google-Smtp-Source: ABdhPJzXU3YvqHPX90w9ejT7eu7mqKFglskeupNE5LeOcrNMt3JV9VU9GfMbF9oO3F+ly0PBAiW/fQZfXXCC1vfjpw4=
X-Received: by 2002:a05:6e02:f81:: with SMTP id v1mr14402482ilo.107.1638401008111;
 Wed, 01 Dec 2021 15:23:28 -0800 (PST)
MIME-Version: 1.0
References: <20211118112315.GD13047@quack2.suse.cz> <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz> <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net>
 <20211130112206.GE7174@quack2.suse.cz> <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
 <20211201134610.GA1815@quack2.suse.cz> <17d76cf59ee.12f4517f122167.2687299278423224602@mykernel.net>
 <CAOQ4uxiEjGms-sKhrVDtDHSEk97Wku5oPxnmy4vVB=6yRE_Hdg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiEjGms-sKhrVDtDHSEk97Wku5oPxnmy4vVB=6yRE_Hdg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 Dec 2021 01:23:17 +0200
Message-ID: <CAOQ4uxg6FATciQhzRifOft4gMZj15G=UA6MUiPX2n9-NR5+1Pg@mail.gmail.com>
Subject: Re: ovl_flush() behavior
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ronyjin <ronyjin@tencent.com>,
        charliecgxu <charliecgxu@tencent.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >
> > To be honest I even don't fully understand what's the ->flush() logic in overlayfs.
> > Why should we open new underlying file when calling ->flush()?
> > Is it still correct in the case of opening lower layer first then copy-uped case?
> >
>
> The semantics of flush() are far from being uniform across filesystems.
> most local filesystems do nothing on close.
> most network fs only flush dirty data when a writer closes a file
> but not when a reader closes a file.
> It is hard to imagine that applications rely on flush-on-close of
> rdonly fd behavior and I agree that flushing only if original fd was upper
> makes more sense, so I am not sure if it is really essential for
> overlayfs to open an upper rdonly fd just to do whatever the upper fs
> would have done on close of rdonly fd, but maybe there is no good
> reason to change this behavior either.
>

On second thought, I think there may be a good reason to change
ovl_flush() otherwise I wouldn't have submitted commit
a390ccb316be ("fuse: add FOPEN_NOFLUSH") - I did observe
applications that frequently open short lived rdonly fds and suffered
undesired latencies on close().

As for "changing existing behavior", I think that most fs used as
upper do not implement flush at all.
Using fuse/virtiofs as overlayfs upper is quite new, so maybe that
is not a problem and maybe the new behavior would be preferred
for those users?

Thanks,
Amir.
