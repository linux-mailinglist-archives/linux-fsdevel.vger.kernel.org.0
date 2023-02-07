Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87268D6C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 13:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjBGMb6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 07:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjBGMb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:31:57 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1F0BBA8
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 04:31:56 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so42770627ejc.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Feb 2023 04:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GRcCIG+dDuJ3w0Yj3VinRqu4Z/wu11q5y8l0oTXpRtw=;
        b=oiYXST+Sx1KNp7RG1nLg4dousct9D2qsP7Us0W2Xv/L8YbipjmmEuVg0zxguja5TSo
         2tQwPTpAGFLV8siXf96jcboefcUhT+s9wE9wFLhc0E/1+BQWc9FC1+9Fm1WjBtMgZHLT
         8Atop+x7gQ+jd4PopUIv1y3RmvGG4PLf1WdWM9PsHLjzL8WeE+aTVEyfVyeHQDmJO9MV
         /lHjOUJQX8+QflVvFDHv4IqDD2EGp3jyjXoG8NZ2D4aHTvd9oTK6IRp1HnN/TTr6isTK
         Y/3L8y+FszhqYSuAhTVauYQW/YGal6eAKcFA/+bhe/C/Mt5OqeBtbL6R1pSkPnMKIMFD
         wghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRcCIG+dDuJ3w0Yj3VinRqu4Z/wu11q5y8l0oTXpRtw=;
        b=SBx97s9sVmVhniBEzB4GmkM4Blg4CSSHoIY/vM6ue325cb+wPTR1lvpYWCTK//Uqkc
         dMz53bFeofYwV7qcMwz8s3oUZldcZQ7Ow3oOfjZWDc/m9eKGfPk9apN/Tfj/u/gNAsdE
         nqmQNhJfZOj/algfgzUyg1Ce5iXp0+FAXxiz4TdcYHdTT1QySa6w7HU7cffpMOUbIV9p
         u5IBmtI2nbs3FYM3JlEUQZGdFFwfwvmPx6p3ceLztlJrgZnoape+W3fihFv3XHnZNqne
         Vtnv5SBNWChJDdyJ9O52AO4FFuD41xOn4J6J7RKgsYQu6SJAOD+qFM/GPH7ZXrWfFCUq
         ZD6g==
X-Gm-Message-State: AO0yUKVdV5llrxM9wdSpWbnMa1dAmsyx+s8HGex4b8CZCTKTo07viRB0
        r0IYtTA5RlijLNTLmc+ylnCT6idXD8w4n1ddd8XBgw==
X-Google-Smtp-Source: AK7set/rtoR31FzqMlQZzNJSLVlJpI/fZtwQqGagBnncuuGFbNyCb+V7+VT7RiCd3uPbvQ06bV7z4HgpLUsW5AVSrTc=
X-Received: by 2002:a17:906:6957:b0:886:73de:3efc with SMTP id
 c23-20020a170906695700b0088673de3efcmr907769ejs.87.1675773115541; Tue, 07 Feb
 2023 04:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20230206134148.GD6704@gsv> <22843ea8-1668-85db-3ba3-f5b4386bba38@wdc.com>
In-Reply-To: <22843ea8-1668-85db-3ba3-f5b4386bba38@wdc.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Tue, 7 Feb 2023 13:31:44 +0100
Message-ID: <CANr-nt2q-1GjE6wx4W+6cSV9RULd8PKmS2-qyE2NvhRgMNawXQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC]: File system data placement for zoned block devices
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        =?UTF-8?Q?J=C3=B8rgen_Hansen?= <Jorgen.Hansen@wdc.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "javier@javigon.com" <javier@javigon.com>,
        "hch@lst.de" <hch@lst.de>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "j.granados@samsung.com" <j.granados@samsung.com>,
        Boris Burkov <boris@bur.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 6, 2023 at 3:24 PM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 06.02.23 14:41, Hans Holmberg wrote:
> > Out of the upstream file systems, btrfs and f2fs supports
> > the zoned block device model. F2fs supports active data placement
> > by separating cold from hot data which helps in reducing gc,
> > but there is room for improvement.
>
> FYI, there's a patchset [1] from Boris for btrfs which uses different
> size classes to further parallelize placement. As of now it leaves out
> ZNS drives, as this can clash with the MOZ/MAZ limits but once active
> zone tracking is fully bug free^TM we should look into using these
> allocator hints for ZNS as well.
>

That looks like a great start!

Via that patch series I also found Josef's fsperf repo [1], which is
exactly what I have
been looking for: a set of common tests for file system performance. I hope that
it can be extended with longer-running tests doing several disk overwrites with
application-like workloads.

> The hot/cold data can be a 2nd placement hint, of cause, not just the
> different size classes of an extent.

Yes. I'll dig into the patches and see if I can figure out how that
could be done.

Cheers,
Hans

[1] https://github.com/josefbacik/fsperf
