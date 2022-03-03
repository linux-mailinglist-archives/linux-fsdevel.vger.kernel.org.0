Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7702C4CB801
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 08:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiCCHjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 02:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCCHjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:39:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9732955210;
        Wed,  2 Mar 2022 23:38:29 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso3616674pjb.0;
        Wed, 02 Mar 2022 23:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4PtnP3K3zaO67GevWuv4V5LSWib25XqjvFapj0F6Bg=;
        b=I9cL01ZpjtBtK2lgplU5gULgz9S4d79BJRTWrmTf0UrluMNfBGMUX5iBJK4ZHbSfbn
         W/xR2FzGE1X69QzdF7LKnmiHGVn79gvlZLW3ekBacVtHRKllfZlPw0rdh9vf8cxmsRqa
         FQpy8OyfMpUfRgW3TC6PDH3PVsylEdgl3+EHN8wZdJ5V0ZfZCToO/6lTXMciFuhoPZRq
         keQYkHPEEZa9XEiRYvfwc712G8HEAI2Sdk5x3CBz34b8mmDqTlIZYHCm+5i/B5F9Pvyz
         QJff81ljsSD5SIMee/z1ueu2OAtBu3qY3W4EKe+9Y4HCP9ksnGOjXH2YB6WbKP0LFxlf
         Tv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4PtnP3K3zaO67GevWuv4V5LSWib25XqjvFapj0F6Bg=;
        b=FjAl46Zg9azn5LJRsLZ/0sgfIHVUoYDGwXsAFkNUEaZEdmb/fwhujPqTkjCJ9t1wF6
         i6n3QyW2Uzst1j9ZfDov9NqOmNwktH14YZeJIfTRoB/bUE1GIipVKeaRdQ4LMSGanw91
         dnbCIkFttO1/tFur+CZiP681ZnYCgo5CiApqEQv8p+V99huG6oeKftKh1ZBXIvl6jTEj
         ubzRQaFPYMRtzglQ/kAX9n8nmd7vcsGA7pC7+C9RHJ0WENmiByN9rGxgE7QLpCDvz8v5
         B3yIW+EM9bp+hIKNePa681N4GNNQvGe6JP7iJ/JAc50uwjeLDWFeSrK5hXfO2+IqxJ6H
         swGg==
X-Gm-Message-State: AOAM532unhz0CqTvVJ8DU3ciOoBlj/qZ/hFM9tHF96ZcH5kBHOZrDjjg
        tKnQmoKEyLVn947zzodvydVZaLaqy2RzWhXQoFg=
X-Google-Smtp-Source: ABdhPJxGmzHg1K953e3nuM/0U22oTreligsoNwsyLrjrfOH7fgth0exeYrmVqUpIcyycBlnBV4GiELbpZSUcnjnV57Q=
X-Received: by 2002:a17:90a:b396:b0:1bc:588a:c130 with SMTP id
 e22-20020a17090ab39600b001bc588ac130mr3885270pjr.97.1646293109074; Wed, 02
 Mar 2022 23:38:29 -0800 (PST)
MIME-Version: 1.0
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
In-Reply-To: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Thu, 3 Mar 2022 13:08:03 +0530
Message-ID: <CA+1E3rLP8-0xr0n6jcHaCPiNTj-WDL+tFPC9Y=WvKaKj_M2fdw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 3, 2022 at 6:51 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Thinking proactively about LSFMM, regarding just Zone storage..
>
> I'd like to propose a BoF for Zoned Storage. The point of it is
> to address the existing point points we have and take advantage of
> having folks in the room we can likely settle on things faster which
> otherwise would take years.
>
> I'll throw at least one topic out:
>
>   * Raw access for zone append for microbenchmarks:
>         - are we really happy with the status quo?
>         - if not what outlets do we have?

Many choices were discussed/implemented in my last attempt to do
append via io_uring/aio.
Without consensus though. Perhaps F2F can help reaching it. I'd like
to join this discussion.

> I think the nvme passthrogh stuff deserves it's own shared
> discussion though and should not make it part of the BoF.

Yes indeed, there is more to it.
We may anyway have to forgo append (and other-commands requiring extra
result) in the first drop of uring-passthru at least. For good
reasons. But let's discuss that in a separate thread along with some
code.

Thanks,
-- 
Kanchan
