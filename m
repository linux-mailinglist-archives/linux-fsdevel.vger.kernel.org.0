Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6683E7EB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 19:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhHJRfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 13:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhHJRe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 13:34:27 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFCDC061299
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 10:33:14 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h17so18970346ljh.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=y3BZ+wT7TMDVjM2/WQcyPOhYkG/NWjvDbJIsMqFI2RA=;
        b=RsiBBdA9QKOcTCF5lGXKVsjmClQ3sMV8nYRHi5UzQ6RFRdaZ6t981j56diJ7q3WLiT
         dSrogDmRt6kwHS+J+pcIdphvlu5Vk62bOJudqb0dzEOf5Tr6sAVMWTY2NbEn++ZnSdaf
         F4yj6h4F7VBk6uVCXN4p2StSiBpSckLhr0NJoCtUTvVh+gCrpSdvA2dss+nT8Q4XWg+b
         4x9fMuBGMminOSzPCK8njOsWexpWsfb2omBFXa3GLhHqzUauC1r8oyB3fDvFuiS7qNjT
         fDqijYMWxjmP3EeBvtWaIUY7Z5YEma/9OhqmI5Ya7ZKqW/5hzlkm8xAdNsqyzESz/5Xj
         5sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=y3BZ+wT7TMDVjM2/WQcyPOhYkG/NWjvDbJIsMqFI2RA=;
        b=a9HfWamiFZ0Jk+22YV805sJgVTZBdrnzHTnnPd0uxFO36B2SOKFzPoQQv+qsf3n/hk
         LgbEzNnWNTGflBC4SsW5weIj8u39VvhjzoJEzx0kjlhxaNg6oMMyQPblKQnQw0M3KXbO
         Re8E5Tk+DNzFt74quKF/Z8pHfVYYufh/UjFLSBSRcSqVjahbetpBgJa9RiPNpQ8rxqlW
         IMsTSu5FPHh4v1+AvQP6zmjhJu55wXR4zq8O26YwxQ8Xsb9ukkihX+uQwVM4gVXLi8aB
         GBxEAPgrqYxp+OFqAaqXRG72dpswm4lWNTc7lKAiFpp3oErZhQfYeTxMdzVWLR77uK3O
         wS0w==
X-Gm-Message-State: AOAM533vSDOTPcCeJMQy73mKXVfxbhisNwFa5xIYQNVq9+AfdzBDrl87
        fxTbfDEvtSuj3hCV2jBWVeoiiaSoeQrK/UgHGgg=
X-Google-Smtp-Source: ABdhPJw+sC+pBQw0G+0ULVvin/r/jCVVb1V7XUqN67UCoWrnBzyIXnaSzK5br1SZrCupI/L0LIZWgMfi7vhpZK+Wcm0=
X-Received: by 2002:a05:651c:32c:: with SMTP id b12mr1745558ljp.198.1628616792032;
 Tue, 10 Aug 2021 10:33:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac2:5d2e:0:0:0:0:0 with HTTP; Tue, 10 Aug 2021 10:33:10
 -0700 (PDT)
Reply-To: majidmuzaffar8@gmail.com
From:   Majid Muzaffar <ing.abdullabin.rishid.me@gmail.com>
Date:   Tue, 10 Aug 2021 20:33:10 +0300
Message-ID: <CAFsu49XXzY7ugKhGzJm5OPKe2LG1R35c-Dkp83VgS3+u27y=sQ@mail.gmail.com>
Subject: Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Salam alaikum,

I am the investment officer of UAE based investment company who are
ready to fund projects outside UAE, in the form of debt finance. We
grant loan to both Corporate and private entities at a low interest
rate of 3% ROI per annum. The terms are very flexible and interesting.
Kindly revert back if you have projects that needs funding for further
discussion and negotiation.

Thanks

investment officer
