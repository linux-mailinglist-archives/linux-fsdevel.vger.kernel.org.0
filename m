Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDC03B8BB4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 03:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbhGABR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 21:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbhGABR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 21:17:58 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73118C061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 18:15:28 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w11so6061822ljh.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 18:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DgB5xvfLGqv+7ftjESpLp/lWBPuI1xogoI5TaUtxS9g=;
        b=W2QA6+HjVQVd+huKxzXTiYLaV83o+vfi3JZpiKVphStoPnjpRsSO0fMzhr5iCR25vs
         KZqA+AmxqZ4MjhLTnpUok40Yx6Bz1oatBT+yhy7OUw3ip9igUimrLTa0+z/FIicCjRLf
         5DSbNziCYndG548dt3klUwYFA+x1ETspzH7kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DgB5xvfLGqv+7ftjESpLp/lWBPuI1xogoI5TaUtxS9g=;
        b=X8Lwr261kP5xGmk2qrf847suwwztdP96oRxpKVdp5Fi9KmJiWbulacHQAa8PEWa/me
         xZDdtnqFwJcnv1RtcSCde4MNTCyLe/2ZxJ6HzIuNFiFYEwjOx6PkiTMCtNX2Lh8OZXJK
         jbXQbP5a15UuNDMMIcxKNE6rdGN5t2X4450hqk8RvrVwyCmuAjRylnaQfi8Z3HUgPjSu
         GnRuGcOhMkZ6cf1Zlia563yjowpnyGBBxxWFFHZ5fli8XsgYXDYcglvH1iUQa2HjselN
         GFcIqcqb6Cr60u8YwmVzODvDdd0OL1sBzyZ2nTmNz7AMQeBitsSr3FDE0z3zK71SlAfL
         Afew==
X-Gm-Message-State: AOAM531gBVYDIJt9+mZ/4oV6B4wI1brKdFfF2X2k5BigFfSuPzTMmeI7
        1O4Xu79SwRmQQaRMv3wgPSdQJIbZjVwOSJzx
X-Google-Smtp-Source: ABdhPJxhu047L4w/zLo9m/8MtzkJTwWMMQEeqMSCe6D5cVumB1h/KfNDA6HN9Cpq497DzymC4FpyIw==
X-Received: by 2002:a2e:9b0b:: with SMTP id u11mr735679lji.384.1625102126513;
        Wed, 30 Jun 2021 18:15:26 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id m18sm1152672lfu.67.2021.06.30.18.15.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 18:15:25 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q4so5924523ljp.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 18:15:25 -0700 (PDT)
X-Received: by 2002:a2e:a276:: with SMTP id k22mr9676576ljm.465.1625102125560;
 Wed, 30 Jun 2021 18:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210630172529.GB13951@quack2.suse.cz>
In-Reply-To: <20210630172529.GB13951@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Jun 2021 18:15:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuUxfoYj=dRnzRybg_sOdFPMDx_t06Lz936Pgnh6QCTQ@mail.gmail.com>
Message-ID: <CAHk-=whuUxfoYj=dRnzRybg_sOdFPMDx_t06Lz936Pgnh6QCTQ@mail.gmail.com>
Subject: Re: [GIT PULL] Hole puch vs page cache filling races fixes for 5.14-rc1
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 10:25 AM Jan Kara <jack@suse.cz> wrote:
>
>   could you please pull from

No.

There is no way I'll merge something this broken.

Looking up a page in the page cache is just about the most critical
thing there is, and this introduces a completely pointless lock for
that situation.

Does it take the lock only when it creates the page? No. It takes the
lock in filemap_fault() even if it found a valid page in the page
cache.

This is just wrong.

               Linus
