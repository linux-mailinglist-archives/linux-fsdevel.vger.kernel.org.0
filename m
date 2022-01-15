Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0005148F922
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jan 2022 20:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiAOTue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jan 2022 14:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiAOTud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jan 2022 14:50:33 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A46C061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jan 2022 11:50:32 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id h30so11246837ila.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jan 2022 11:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UwzmeMOBNwN1JbTeTjut7ZpJ4wT9YAhsJEQnK0RfwYs=;
        b=A9N8hObRWiI5uQbCq/MobzU3jh+7pZ8Zwu7M4AqqxEuf9vq0XiYNkQ83ubzaj11w3A
         NqPShwnD2DF3+h9OKAOVluOGafX4pFbLNBK7DuWUQcwQrcrD9iM478q7IVyDYaEA6od+
         7/I8PSXRoopoekVHlnb1fBuA30y8uaO1PkdivACEqHTXw1euwWg0AdavJX8JUChXisFQ
         T2aGh/X9tsn24CEVh/Rqt5Md7NVopKkJyKweA+W1QcKluxqtkA99wd4lSxyZZpeFlkXk
         nXfFkKgaO50LkxyFwpw6bOTsC9eZlAnh6b7S6Irgjxa55g+yzTGSjEoOcDb+X3IpiA7R
         T1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UwzmeMOBNwN1JbTeTjut7ZpJ4wT9YAhsJEQnK0RfwYs=;
        b=2bjmt7rPyIYyRHlVR/H1xRiSaIwDifcbHZL+M6Jq/2cWAtlUF89OfAXgYq5GdXEj1B
         8SfKg/eXWZui3AZNVkd87kzjaVbb2jEh0+pMd04fGJBmxVFkZRguxEAFOBGAKoxF4Ght
         v/Qhi3He103mHZ7a1DCsD8lwP48ier8rVeYwZrYzMTVd/RKpfblJIK+rUTsvx/2HyDdK
         hV9n6yklCU+LJN0yzNOX09FAzpJV68qBBGJGOyFoPgVCvpkfeBjS8g9JxfZZb2oXZEV5
         umMY3SC1Jm6hHpXkCAUvX14ub1T8psJLSITxcL4jOFiYD4/Y2U7yS0/u88J/45mIn9zg
         hEUg==
X-Gm-Message-State: AOAM532ebM0deuBXDcc5smJTyjiFJT8meJGIlqkaGuA/xsE4iSVL4iHi
        JZVbweogU3tnzSF18erUGHv3sijInPVZpUT7Vly5NmGl
X-Google-Smtp-Source: ABdhPJz0i3mx9xqY2Qo73gVWmKr9Lrl+BZvogId3ATyozow577uZY8H6LhrzpLdeaK40jU8lPeL0TUbLfvKQjPSQCUo=
X-Received: by 2002:a05:6e02:1b05:: with SMTP id i5mr7605896ilv.319.1642276231931;
 Sat, 15 Jan 2022 11:50:31 -0800 (PST)
MIME-Version: 1.0
References: <YeI7duagtzCtKMbM@visor>
In-Reply-To: <YeI7duagtzCtKMbM@visor>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 15 Jan 2022 21:50:20 +0200
Message-ID: <CAOQ4uxjiFewan=kxBKRHr0FOmN2AJ-WKH3DT2-7kzMoBMNVWJA@mail.gmail.com>
Subject: Re: Potential regression after fsnotify_nameremove() rework in 5.3
To:     Ivan Delalande <colona@arista.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 15, 2022 at 5:11 AM Ivan Delalande <colona@arista.com> wrote:
>
> Hi,
>
> Sorry to bring this up so late but we might have found a regression
> introduced by your "Sort out fsnotify_nameremove() mess" patch series
> merged in 5.3 (116b9731ad76..7377f5bec133), and that can still be
> reproduced on v5.16.
>
> Some of our processes use inotify to watch for IN_DELETE events (for
> files on tmpfs mostly), and relied on the fact that once such events are
> received, the files they refer to have actually been unlinked and can't
> be open/read. So if and once open() succeeds then it is a new version of
> the file that has been recreated with new content.
>
> This was true and working reliably before 5.3, but changed after
> 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of
> d_delete()") specifically. There is now a time window where a process
> receiving one of those IN_DELETE events may still be able to open the
> file and read its old content before it's really unlinked from the FS.

This is a bit surprising to me.
Do you have a reproducer?

>
> I'm not very familiar with the VFS and fsnotify internals, would you
> consider this a regression, or was there never any intentional guarantee
> for that behavior and it's best we work around this change in userspace?

It may be a regression if applications depend on behavior that changed,
but if are open for changes in your application please describe in more details
what it tries to accomplish using IN_DELETE and the ekernel your application
is running on and then I may be able to recommend a more reliable method.

Thanks,
Amir.
