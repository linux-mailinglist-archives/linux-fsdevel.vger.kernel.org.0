Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A391D7438
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 11:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgERJki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 05:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERJkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 05:40:37 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CC6C061A0C;
        Mon, 18 May 2020 02:40:37 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w18so9136051ilm.13;
        Mon, 18 May 2020 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdms6kI1V+FygiJbqs2W9+OWW1Eb6sNR1jWF1nmy7jI=;
        b=s2IUKdbY3enMQmG1dX2eyNAXUxWkhxcjtIOASGmTWs5lo4cTy3LOBI6XuqCI4YewSG
         i5i+JsDBd4ABTFkMB9jBUuHqLtKn9+j/xBvCpJixXRo59tMDud/DQ/McDu1glkWq8Io8
         6bXJXwj0/lqCHc1S0rf2DKr/ldfzWZoroabktl6SLP0T7OsKjOiawzO8cn53dIVSIx2L
         fjleVT2mcjvwry5lvvRyZrMw3TXb5uOTxdNwOsHdL4gRCqpKo8VugF2O2ehbTQNfJyns
         CvmQ1zdUD/bx9o5NUcxoPFXVgzLem8GsociSdXyrZT/ymZwT4W+HSD9A7qgnQIdilLjb
         sM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdms6kI1V+FygiJbqs2W9+OWW1Eb6sNR1jWF1nmy7jI=;
        b=i5egenXkPxq7E/HJUYV+bzduC8VlxnTuyJDZTGSbJX82pdoowKwSiAc9vpLQqqTIr/
         JyePIkZJiJlzOe2jzeoXwnNqQB9CLqYDw0HXn3COV5zdOQR0A2KwoSQWwVDdCEWqB7uf
         EeubL42yj1pjcyTf6VirecMv3ToMy/d5r12YzEPxdkIe7SfVt0oHnUhyEE/lK4mFQxJc
         yW5qlYXFGac2d9bnvMNPLiGd8rud/ADXW1VQ1UJibcQtQHkwv32bJph/QrzB5D2V2uHp
         xUCyp8BQQslZq93ARHl7YvIBN5eETaHQF2zDjabaYq46SRdoXGz1rFVR+dBOfTDgBlgB
         QLfg==
X-Gm-Message-State: AOAM5300x5JNA5Hv8fRtrg0nyZDjdXcJtCLLpHtwqfFGRnlsD9h3wUrZ
        tmY1lJJWQG+wkc5K2JwVZz+ajWl++PqqmfsbHY4=
X-Google-Smtp-Source: ABdhPJxgg7rmKLZhAoede28E3JcidgqEy/oebAmR/EeZK7KjnvrIRBSTRAbaCZr7oZACwVn1jBpjjgcz7O/uuqaMRAg=
X-Received: by 2002:a92:b69b:: with SMTP id m27mr15494381ill.250.1589794836888;
 Mon, 18 May 2020 02:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200505162014.10352-1-amir73il@gmail.com>
In-Reply-To: <20200505162014.10352-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 May 2020 12:40:25 +0300
Message-ID: <CAOQ4uxjAz5ytbyJMJGvwitpepVnnAKEiQV8QEkzc9yeRyXZoKA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] fanotify events on child with name info
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 5, 2020 at 7:20 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Jan,
>
> In the v3 posting of the name info patches [1] I dropped the
> FAN_REPORT_NAME patches as agreed to defer them to next cycle.
>
> Following is remainder of the series to complement the FAN_DIR_MODIFY
> patches that were merged to v5.7-rc1.
>
> The v3 patches are available on my github branch fanotify_name [2].
> Same branch names for LTP tests [3], man page draft [4] and a demo [5].
>
> Patches 1-4 are cleanup and minor re-factoring in prep for the name
> info patches.
>
> Patch 5 adds the FAN_REPORT_NAME flag and the new event reporting format
> combined of FAN_EVENT_INFO_TYPE_DFID_NAME and FAN_EVENT_INFO_TYPE_FID
> info records, but provides not much added value beyond inotify.
>
> Patches 6-7 add the new capability of filesystem/mount watch with events
> including name info.
>
> I have made an API decision that stems from consolidating the
> implementation with fsnotify_parent() that requires your approval -
> A filesystem/mount mark with FAN_REPORT_NAME behaves as if all the
> directories and inodes are marked.  This results in user getting all
> relevant events in two flavors - one with both info records and one with just
> FAN_EVENT_INFO_TYPE_FID.  I have tries several approaches to work around this
> bizarrity, but in the end I decided that would be the lesser evil and that
> bizarre behavior is at least easy to document.
>

Hi Jan,

Were you able to give some thought to the API question above?

I would really like to be able to finalize the design of the API, so
that I will be able to continue working on the man page patches.

Re-phrasing the API question that needs addressing:

With FAN_REPORT_NAME, filesystem/mount watches get -
1. ONLY events with name (no events on root and no SELF events)
2. Each event in one flavor (with name info when available)
3. ALL events in both flavors (where name info is available)
4. Something else?

The current v3 patches implement API choice #3, which is derived
from the implementation choice to emit two events via fsnotify_parent().

My v2 patches implemented API choice #2, which was the reason
for duplicating name snapshot code inside handle_event().
I considered implementing merge of event with and without name,
but it seemed too ugly to live.

We could also go for an API that allows any combination of
FAN_REPORT_NAME and FAN_REPORT_FID:
FAN_REPORT_FID - current upstream behavior
FAN_REPORT_FID_NAME - choice #3 above as implemented in v3
FAN_REPORT_NAME - choice #1 above

At one point, I also considered that user needs to opt-in
for named events per filesystem/mount mark with
FAN_EVENT_ON_CHILD. This flag is implied in v3 for
all filesystem/mount marks by FAN_REPORT_NAME, while
for directory marks it is opt-in as it has always been.

At the moment I went with choice #3 in v3 because I felt it
would be the simplest of all choices to document.

I didn't want to invest time in documenting behavior if you find it
unacceptable. If you are swaying between more than one option,
then I am willing to try documenting more than one option, so we
can see what the result looks like.

Thanks,
Amir.
