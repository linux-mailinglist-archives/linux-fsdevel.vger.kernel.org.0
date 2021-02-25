Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95463325A1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 00:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhBYXTV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 18:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhBYXTU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 18:19:20 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E82C061574;
        Thu, 25 Feb 2021 15:18:40 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id g8so3773146otk.4;
        Thu, 25 Feb 2021 15:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cM/27TDPWU9n1B6VG3wJi0mVX0hV7v6Zx7CIoZXnIRw=;
        b=t8DFX+2qkbRzbf3IBxdYLIa9x3/shke3R7pFeGnj1vm31atPMFVwmCzr+iFDl7G1Xl
         8XwZ3M4KDwiq8ULIY8hhcyjUWewbRc5Q/p7JSl3to4LK0/18kB/wnK4If70UvOeEdwTD
         QmkplfV0XF30aLP43W0/dM1Hl+WctFaVukOxxQ1cqm6BQ3u7k9YhWy2PpeVT341MpoPT
         St93wzwa1sfbLpLWeQRAv0UZbheTMyRHs6K11n82aG+iEM3DnzV2ZHPg30uU4FxYUFW6
         mBbh8xFtdrBVTXDT6ASvM4twqpWaNWWH1hfRG3LjC8QvjPdcRZemw7GWCCGvfodzkaJN
         UaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cM/27TDPWU9n1B6VG3wJi0mVX0hV7v6Zx7CIoZXnIRw=;
        b=OG/dyiuAIHTJ/a7x4eEnIVvZLDC4wao/kWSJ9psqPZ0JFYpLReZIiDDlrlRRJ8VuDe
         7+iytKuFpgQoNfNYBh/roN5uudrAphUcn6AEHWtSbr2ZhIakIj84eN5g0Z1IihPM5SQe
         oabVmD7bGhHN4E1Enm93MTO8DJbotLHK+Mefj51fxmzchSsUi+iRL5PCdKtT62IH9rt5
         qHH0S6/1ic7xyO5KwJuA2EzK8Dt02NOKMJ8fqRnkAI4PX+FIoCUa2ikarlF+MkSGvy2C
         hdaNkaDdUFix2ht5pZJ4NkRtUyU77hpUcmrwhyrOgl/lxJMenJKzFrxBuho2GihW4XCL
         721w==
X-Gm-Message-State: AOAM530ESL53dtfcr86QyMq8oRDd4TUw1zyvhTMLKlch/0SyLzj2Cr1p
        AXYyP3ewDuVLfY58GADStMYrWVgtGmb/x+eY1eA1IS5DgLaM8A==
X-Google-Smtp-Source: ABdhPJy2xIHE+jaUaMITTNUcOiQL8Y4dNasb7T+8SKhMztdlS1CaMSTOOjjWw+bDu/fYkEI5lRqkOZJyLqAm8sfTmek=
X-Received: by 2002:a05:6830:1688:: with SMTP id k8mr73901otr.45.1614295119840;
 Thu, 25 Feb 2021 15:18:39 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
 <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
 <20210225132647.GB7604@twin.jikos.cz> <CAPkEcwjcRgnaWLmqM1jEvH5A9PijsQEY5BKFyKdt_+TeugaJ_g@mail.gmail.com>
In-Reply-To: <CAPkEcwjcRgnaWLmqM1jEvH5A9PijsQEY5BKFyKdt_+TeugaJ_g@mail.gmail.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Thu, 25 Feb 2021 15:18:28 -0800
Message-ID: <CAE1WUT7JOyeWi8DHZS3fNMAq+GX9qsm7iPC01x60m1W84ZdPrA@mail.gmail.com>
Subject: Re: Adding LZ4 compression support to Btrfs
To:     Jim N <northrup.james@gmail.com>
Cc:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for your comments, Jim. I was originally going to abandon my
thoughts about LZ4 on btrfs - but I didn't realize that FAQ was from
2014.

> lz4 has had ongoing development and now exists in other linux kernel fs's.
What other filesystems currently employ LZ4? Not as familiar with it
being used on other filesystems.

   -Amy IP
