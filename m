Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7683F4D1374
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 10:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiCHJdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 04:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiCHJdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:33:54 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5573191B
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 01:32:55 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id t8-20020a0568301e2800b005b235a56f2dso4012458otr.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 01:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=befouEOLs7gEwW/9zrJZYjQYxPJ4HO32tJhcwqgsRGs=;
        b=SGdSAQjefewuGEuy4daE/ymnwn+Cd2AOGY5dqFNw4OlkkSESBA4T3Q+tIx9HID0M7m
         aiUUzMj2f84t0zFsyzh++t+p381hBVmaA9ZxeW1aSsaWn4oYT2pBW7O1sHf12lSV85V3
         ZKsiye9UqlxzCzXseT3VoyOaZrWPxBc0hy7z5jDWhGJy1WkZnXr0+K9+hph9g3RYr7n9
         J/tfbkUOrDm8nCYxDH/jfFzaxnBwVeWacqsOZ7MIXiXLYBZ3zvBR6xNPYtnw8HGetWPi
         XNVVS2T4/r7YD9W2a2BdNq4mFQFXqI7o+I0uUUTL8M2O4OJEDbgEUxbBrO5J3aJQAW1/
         TWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=befouEOLs7gEwW/9zrJZYjQYxPJ4HO32tJhcwqgsRGs=;
        b=XR8LyyaRYyOMPRxSq+zxNA7HY7zvHFn3VFFxVBWJYLtuhv2tzYtE45wYsJfL8whEyD
         TvlRmRPk9La0WP3qncgUTNcOcPlUrlMlfGDfh1HFlQu2x0mLMDKEP8CXLt7IIZWGAJcs
         nPhhrIJvRMeycGpJrCVL/F+lIYBGy6YrwgW+48V6iGAMKIe8CiGaINOqDhxRUOiir1cK
         eg/G3e88k5LcSgMMfKQxa+ItiubS0NF10p9Mq7/dBGpji+3aCqWNjQnFAHgYzIp/Y68H
         vIvS8APFkfd7NaINbWcqHP5h4B2DCQ7TUW4SPSHGkSquYmyk+rQsC0pUGptGaQdJXr0F
         u0Ow==
X-Gm-Message-State: AOAM530ngc2gvQoFq3M9xUPNhSOEbCiWaw/3oKq13SwyEByXbJDTkZeX
        gh2P5Fek+0Y7j662RTy3yKxmoiwjNMCOk962MTY=
X-Google-Smtp-Source: ABdhPJyUPMNCea8Bf5pKcFe/SIoPvgx90rtOcD9Ul+AE5T6iqaFjw/f2MG8sU3uYtMOUq/srw3DnvLe1iyuaFn8U/H4=
X-Received: by 2002:a9d:5cc8:0:b0:5b2:35ae:7ad6 with SMTP id
 r8-20020a9d5cc8000000b005b235ae7ad6mr4458084oti.275.1646731975073; Tue, 08
 Mar 2022 01:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20190212170012.GF69686@sasha-vm>
In-Reply-To: <20190212170012.GF69686@sasha-vm>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 8 Mar 2022 11:32:43 +0200
Message-ID: <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
To:     Sasha Levin <sashal@kernel.org>
Cc:     lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
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

On Tue, Feb 12, 2019 at 7:31 PM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi all,
>
> I'd like to propose a discussion about the workflow of the stable trees
> when it comes to fs/ and mm/. In the past year we had some friction with
> regards to the policies and the procedures around picking patches for
> stable tree, and I feel it would be very useful to establish better flow
> with the folks who might be attending LSF/MM.
>
> I feel that fs/ and mm/ are in very different places with regards to
> which patches go in -stable, what tests are expected, and the timeline
> of patches from the point they are proposed on a mailing list to the
> point they are released in a stable tree. Therefore, I'd like to propose
> two different sessions on this (one for fs/ and one for mm/), as a
> common session might be less conductive to agreeing on a path forward as
> the starting point for both subsystems are somewhat different.
>
> We can go through the existing processes, automation, and testing
> mechanisms we employ when building stable trees, and see how we can
> improve these to address the concerns of fs/ and mm/ folks.
>

Hi Sasha,

I think it would be interesting to have another discussion on the state of fs/
in -stable and see if things have changed over the past couple of years.
If you do not plan to attend LSF/MM in person, perhaps you will be able to
join this discussion remotely?

From what I can see, the flow of ext4/btrfs patches into -stable still looks
a lot healthier than the flow of xfs patches into -stable.

In 2019, Luis started an effort to improve this situation (with some
assistance from me and you) that ended up with several submissions
of stable patches for v4.19.y, but did not continue beyond 2019.

When one looks at xfstest bug reports on the list for xfs on kernels > v4.19
one has to wonder if using xfs on kernels v5.x.y is a wise choice.

Which makes me wonder: how do the distro kernel maintainers keep up
with xfs fixes?

Many of the developers on CC of this message are involved in development
of a distro kernel (at least being consulted with), so I would be very much
interested to know how and if this issue is being dealt with.

Thanks,
Amir.
