Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF3A24D669
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 15:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgHUNqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 09:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgHUNpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:45:00 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD57FC061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 06:44:46 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i26so1459049edv.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8B/t7yTfV4aCXW44FXG3bmocf9Ja1nIvTptUmAoLk2I=;
        b=YiqeFGCovK2Atgj4oFwpmSaAaQzsRXTNOncyOK7+loEAS8Yprvb6vpPe2NHQ1O9pz9
         5KCxqDUScjc2LRr/Q5cMDuahQ3HYxaaT5wVUI/NaBnwbQGSlFtF3x9PUjiYBnba1J/56
         2JJiq4ggd993EpoQm94myFrbzzl/0XKVhTEiqZiM/T79IZlLiwyLcdphYNpXQXUoBNKC
         rX/164ay6LJhaX+Pt8NaUV+ZXDqGIcwionSdxp6gfvmt4oW6vrF0EsjYkDFzrS3wvwsD
         6PJFXe/Yz5br/5iLQkWD0r1qzdo3Z45Dif2cssxIW2wgnOx5dS9q3/85aI+o39comYUo
         9rSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8B/t7yTfV4aCXW44FXG3bmocf9Ja1nIvTptUmAoLk2I=;
        b=LVoHD3Romu2s2QGEsDF9y+UVCpPD1Ig9ukFCNnhBieuZc3rEHaYIAM9dySyLn9CU06
         OVHgGSwtRKZMEvUdmlyI9OglwgWDiLl2wpvaZhZBLuyzMrQOzLEKQWh7CF00fIquPA7K
         Q8dCdILS8eWrDUTD/Bgs99OBY2vbqZ2aMGXzc/hBVUMCaHSUqZyCCuFJezyO6tuV+2pK
         XmEI48Co8EgnlobcwSlUlq6bDpDBbfDw498mQ7zGakpsFhPB+eCeDiemBuzwbJUsWqjR
         SSV0JsPJ7gjTOUXxZHQ+UZRQqtKyYHmun40ewaYUIJScsIvvVtyTGH693wUXTZBQoWBT
         zFkg==
X-Gm-Message-State: AOAM533CANCrotbh/NzzuKMbGjS/qL8TSDC/JaSPWp9mtI8lMy+HDX4H
        SEKWZTUkfi3ohxgmQO42DAuYeQZUDUQNd4EXggy/
X-Google-Smtp-Source: ABdhPJw72UFC+QGQjFeIKXNk4CuUdgr6pCtdnpiWCmvvQyryv2srY1rZ+SRz75W64EYTltMcVNFALFvY7OE3RBlAT5c=
X-Received: by 2002:aa7:c353:: with SMTP id j19mr2957479edr.128.1598017485328;
 Fri, 21 Aug 2020 06:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com> <20200819195935.1720168-5-dburgener@linux.microsoft.com>
In-Reply-To: <20200819195935.1720168-5-dburgener@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 09:44:34 -0400
Message-ID: <CAHC9VhQDjN=hcyHewNGZhdakNQBKBav3TsnuqJ-jV_uCdzJL1A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] selinux: Create new booleans and class dirs out of tree
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 3:59 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> In order to avoid concurrency issues around selinuxfs resource availability
> during policy load, we first create new directories out of tree for
> reloaded resources, then swap them in, and finally delete the old versions.
>
> This fix focuses on concurrency in each of the two subtrees swapped, and
> not concurrency between the trees.  This means that it is still possible
> that subsequent reads to eg the booleans directory and the class directory
> during a policy load could see the old state for one and the new for the other.
> The problem of ensuring that policy loads are fully atomic from the perspective
> of userspace is larger than what is dealt with here.  This commit focuses on
> ensuring that the directories contents always match either the new or the old
> policy state from the perspective of userspace.
>
> In the previous implementation, on policy load /sys/fs/selinux is updated
> by deleting the previous contents of
> /sys/fs/selinux/{class,booleans} and then recreating them.  This means
> that there is a period of time when the contents of these directories do not
> exist which can cause race conditions as userspace relies on them for
> information about the policy.  In addition, it means that error recovery in
> the event of failure is challenging.
>
> In order to demonstrate the race condition that this series fixes, you
> can use the following commands:
>
> while true; do cat /sys/fs/selinux/class/service/perms/status
> >/dev/null; done &
> while true; do load_policy; done;
>
> In the existing code, this will display errors fairly often as the class
> lookup fails.  (In normal operation from systemd, this would result in a
> permission check which would be allowed or denied based on policy settings
> around unknown object classes.) After applying this patch series you
> should expect to no longer see such error messages.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
> ---
>  security/selinux/selinuxfs.c | 113 ++++++++++++++++++++++++++++-------
>  1 file changed, 90 insertions(+), 23 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
