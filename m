Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E83A240B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 07:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhFJFjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 01:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJFjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 01:39:41 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C75C061574;
        Wed,  9 Jun 2021 22:37:30 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id f10so10947096iok.6;
        Wed, 09 Jun 2021 22:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9dmnYE0y0Gsr+v9rHoqwXPhrGtNSKxuEvOD8vEMF1E4=;
        b=VOj4VqFXI73NgD0weDnUVSB0mG8K2sARXYmiYAHIeBx4pI6wmMB5p5geyzPSZ2G7NB
         9m8khL1B1s4Yq5pd0pOClUxGswMKx8O56b1tdIPrEnHDQbX++YATQkOk9fFWZwoNU3RE
         clkEnLhAEhuyvNg1grCN0+p1LMIPGEiUJwsHoGwvd6GcMNB2bcB+PbSuhvy0nagSfA+N
         mZ0H6NsKPeN3znaRJV83cmXHbqS7k/IdfwSw/cTrATdKsgZteCqeuWxDyUa45HLf5oAw
         4G/ws2bn/mslui5PML2AElDYLA0KAEnzcpCUjlvrv+zXI/bcxfwjgY2Luhc1ncCAg1hr
         kREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9dmnYE0y0Gsr+v9rHoqwXPhrGtNSKxuEvOD8vEMF1E4=;
        b=bYtoNXdZXzO4z9X+DbGo+gdBqgRW56dP6/wFXH9OkpHEfTTCL7HW/SIMWJUw5E5qgF
         KLrO0IkqXK0ayETwmxJQkh/OreJdvGU4PfyGdyYJAKzYLuXI6LSxUVCXK43MRE96Iq4Z
         xw3fkHJYl00MIQaWUZ8dINtTogIy7LWH0y8UJF1SZ+oeKYbCdjqsTeH86MJYf+NWt2+6
         dINR1HK9Hh31Yi+BDYodeYgXyH9vntqkrFvOT4ri3755c+4OKAdm7hIEV5qjncwVljYs
         6GZfJv5BPYE8e6b6Kyc1AoJUsjxryeekOv4cIMvUMnRGO18CPxnF/Z0k6Ai2WxOxCU1o
         39Pw==
X-Gm-Message-State: AOAM530ZOl+VhdF4V3/syj+a+IUjNa/nNe4HDAuOAq0i1GiWnev1JQio
        tA1WWRPsX5kp2X3wdILlrYhbD3CmRhKuzIMip0k=
X-Google-Smtp-Source: ABdhPJyK0+pwduOBWZaXHCiupK+wY4f+DFwHVRLK3sPF25gDRPwc/khlIGC/HMhXxSl8AiHMUenzI5Jrgdh+Q5CwL6M=
X-Received: by 2002:a6b:3119:: with SMTP id j25mr2424840ioa.64.1623303450197;
 Wed, 09 Jun 2021 22:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623282854.git.repnop@google.com>
In-Reply-To: <cover.1623282854.git.repnop@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 10 Jun 2021 08:37:19 +0300
Message-ID: <CAOQ4uxgR1cSsE0JeTGshtyT3qgaTY3XwcxnGne7zuQmq00hv8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 3:19 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> Hey Jan/Amir/Christian,
>
> Sending through v2 of the fanotify pidfd patch series. This series
> contains the necessary fixes/suggestions that had come out of the
> previous discussions, which can be found here [0], here [1], and here
> [3].
>
> The main difference in this series is that we perform pidfd creation a
> little earlier on i.e. in copy_event_to_user() so that clean up of the
> pidfd can be performed nicely in the event of an info
> generation/copying error. Additionally, we introduce two errors. One
> being FAN_NOPIDFD, which is supplied to the listener in the event that
> a pidfd cannot be created due to early process termination. The other
> being FAN_EPIDFD, which will be supplied in the event that an error
> was encountered during pidfd creation.
>
> Please let me know what you think.
>
> [0]
> https://lore.kernel.org/linux-fsdevel/48d18055deb4617d97c695a08dca77eb57309\
> 7e9.1621473846.git.repnop@google.com/
>
> [1]
> https://lore.kernel.org/linux-fsdevel/24c761bd0bd1618c911a392d0c310c24da7d8\
> 941.1621473846.git.repnop@google.com/
>
> [2]
> https://lore.kernel.org/linux-fsdevel/48d18055deb4617d97c695a08dca77eb57309\
> 7e9.1621473846.git.repnop@google.com/
>
>
> Matthew Bobrowski (5):
>   kernel/pid.c: remove static qualifier from pidfd_create()
>   kernel/pid.c: implement additional checks upon pidfd_create()
>     parameters
>   fanotify/fanotify_user.c: minor cosmetic adjustments to fid labels
>   fanotify/fanotify_user.c: introduce a generic info record copying
>     helper

Above fanotify commits look good to me.
Please remove /fanotify_user.c from commit titles and use 'pidfd:' for
the pidfd commit titles.

>   fanotify: add pidfd support to the fanotify API
>

This one looks mostly fine. Gave some minor comments.

The biggest thing I am missing is a link to an LTP test draft and
man page update draft.

In general, I think it is good practice to provide a test along with any
fix, but for UAPI changes we need to hold higher standards - both the
test and man page draft should be a must before merge IMO.

We already know there is going to be a clause about FAN_NOPIDFD
and so on... I think it is especially hard for people on linux-api list to
review a UAPI change without seeing the contract in a user manual
format. Yes, much of the information is in the commit message, but it
is not the same thing as reading a user manual and verifying that the
contract makes sense to a programmer.

Thanks,
Amir.
