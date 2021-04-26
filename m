Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A44336B220
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhDZLMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 07:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbhDZLMX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:12:23 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B91C061574;
        Mon, 26 Apr 2021 04:11:42 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a11so3163197ioo.0;
        Mon, 26 Apr 2021 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZ8PC4Mr9yYwubc3N66DSmRD6uN3k59USQz1/JxLvJQ=;
        b=m34u1+3JOHz135RUMFft6PKY6swpc//9UzoVUnb513jDmNawXNWQF0KaoZSb4eMZZp
         fQwPbkag1KKupKuPfwfUYKNUK0EuzTfJc/jXOypg/q7draPJqFw0ekjoOmLVaQEqY+JB
         GZOiypF41j84YWimXBwEj6OzVxNVt+wbJenikrYBm+9/DMefqCOY6QE4ND2Ujy6yp3Fh
         YUWe7oL6BtryW18JmjAhjy6acDreReMqcmFGVG6V6a+Ku5NnsuzP8eZ/Z8uTCzmPVrfU
         9/tpURI5yCikXO6aCvyx6jG8XTb8CRJ4hquLuoB6sGEWU/55W9x4SPPQdzQgTm7Hb1S3
         DapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZ8PC4Mr9yYwubc3N66DSmRD6uN3k59USQz1/JxLvJQ=;
        b=JBXsJRCU2kXNtAJYpBJ+6uHVyhjfVqEO7eYVZu9h5sLwPY4KuzAWc97ZoSGzTm5DEz
         tqRMRxSkerCf3VgdbEdzRpGsOOirFazJ3WL8rnceWHok8HYZksII5EB7zMn3E4Te5zqf
         BMPL5MdEbrwQ1j0xOuHYLhfQRaf6pnAh3k8iadK3Z0njTbEnnzHhBtK+yWmD8dOoW7Py
         cV6DMj2IVNenT/SWuxV/lvwK56pb/FR+9RdXE+cfqyZNXoyUhewlpkklbSh7bV4nRL+l
         7mRHB+7rgzEqqLpw5BmESYdW3F499LhkS8LdaGQQgxRxtlwliOxAv5qzLCyn7kWZDXye
         u3Kw==
X-Gm-Message-State: AOAM533GZzrf509MMrl+SI2+hiaazvXmh2SjUcFJUGFV4KdCBSRt3SjB
        8naFVQPmV6sAn201RwxBW7EeYud8tKjSBqVRT4vyX3mcpBY=
X-Google-Smtp-Source: ABdhPJwhhPccCc/bondZD05boWE68T4viBmeLegREpNZh7G/jsMkj0F1uxFzj4/5ypUq5EP2xFjO066/xYAc98XD+e4=
X-Received: by 2002:a6b:f00f:: with SMTP id w15mr13567372ioc.72.1619435501875;
 Mon, 26 Apr 2021 04:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <20210419132020.ydyb2ly6e3clhe2j@wittgenstein> <20210419135550.GH8706@quack2.suse.cz>
 <20210419150233.rgozm4cdbasskatk@wittgenstein> <YH4+Swki++PHIwpY@google.com>
 <20210421080449.GK8706@quack2.suse.cz> <YIIBheuHHCJeY6wJ@google.com>
 <CAOQ4uxhUcefbu+5pLKfx7b-kOPP2OB+_RRPMPDX1vLk36xkZnQ@mail.gmail.com>
 <YIJ/JHdaPv2oD+Jd@google.com> <CAOQ4uxhyGKSM3LFKRtgNe+HmkUJRCFwafXdgC_8ysg7Bs43rWg@mail.gmail.com>
 <YIaVbWu8up3RY7gf@google.com>
In-Reply-To: <YIaVbWu8up3RY7gf@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 26 Apr 2021 14:11:30 +0300
Message-ID: <CAOQ4uxhp3khQ9Ln2g9s5WLEsb-Cv2vdsZTuYUgQx-DW6GR1RmQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Amir, I was just thinking about this a little over the weekend and I
> don't think we discussed how to handle the FAN_REPORT_PIDFD |
> FAN_REPORT_FID and friends case? My immediate thought is to make
> FAN_REPORT_PIDFD mutually exclusive with FAN_REPORT_FID and friends,
> but then again receiving a pidfd along with FID events may be also
> useful for some? What are your thoughts on this? If we don't go ahead
> with mutual exclusion, then this multiple event types alongside struct
> fanotify_event_metadata starts getting a little clunky, don't you
> think?
>

The current format of an fanotify event already supports multiple info records:

[fanotify_event_metadata]
[[fanotify_event_info_header][event record #1]]
[[fanotify_event_info_header][event record #2]]...

(meta)->event_len is the total event length including all info records.

For example, FAN_REPORT_FID | FAN_REPORT_DFID_MAME produces
(for some events) two info records, one FAN_EVENT_INFO_TYPE_FID
record and one FAN_EVENT_INFO_TYPE_DFID_NAME record.

So I see no problem with combination of FAN_REPORT_FID
and FAN_REPORT_PIDFD.

Thanks,
Amir.
