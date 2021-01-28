Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF963077BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 15:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhA1OQH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 09:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhA1OQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:16:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF40BC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 06:15:24 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v15so5572491wrx.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 06:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=82FN5PNqEoj/mvZFSbez/zX7p4CTgWs6rdhQWNIXhYA=;
        b=fBFFUMgej6bbidDQptcu9Q3KBDcJw5K4oNkt3fFuGYXBfgfPL7NCJrKqqzWvrGMiEz
         lVi8tPTgd0l166n3CSUvawgWXcHgDeNe41+ZbvCyBHvyXFyLmYRrzZcGLFeB88Ynz/oz
         cPoSGXqwl0HHD0Ji2Gh3vHc0qe0w/WRlBBMqsOrJUGLjFLRqIk1h5uRNtOR/ncuGTwj+
         byp7Ha4hwg9Yg+Jw1UbvEeJdKfBqpsmtJxvjHWVTTPohDf5awl07UBsbtmqvJtc7hRzU
         5OGuLZy8Rr/a7Vc+ZJekDhj/RpkJEQf7VGsz5IqgmXyiACEym25qyXh0U3mLnjXz7WX2
         i8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=82FN5PNqEoj/mvZFSbez/zX7p4CTgWs6rdhQWNIXhYA=;
        b=QJyH8MyDa9m4CDFsjkewKzvnHb//Kn3plbU3Y2P+tapiWEdhl4fm9CKTMUhltrFPC9
         C5a0QGwsAUw6otrFidZDmZ9drJf+8SlbrUQHre9CcmVaR/K0vQJQQZEsmvqhnKJYNEyD
         K5iQsyPLev/yAFDlFsvrW8OgPneLn/7qpGTOIEHvMMGr/jIzNztaHwHC/uZSFPbiS6O/
         YCdXehBr2WFQWftm4G3xBaGxPdVRw1+8WoqwGSMZV7SjWlPMhNOWHmSAtHMrCMjgPHEx
         UzymE0dwPiT8DWX6dDGhdh94rCAsrY2eNBJxdFC9A5i3H1L+SooxsDAblzJOIM6wyzp5
         syzA==
X-Gm-Message-State: AOAM533appISvOWaLS4MaxoMdxxH3aWg2SOMutrovnyEoGMwecovfhik
        v4DCkXf/JG0gFngzSuUuYoCXiQ==
X-Google-Smtp-Source: ABdhPJyXYqeZ3302QBKgfqK55u3wRvF3uxxr3cTTMdkXJZ+7oxjyCPXDqpbSOjhzBtVfBpdxKSPzlA==
X-Received: by 2002:a5d:664c:: with SMTP id f12mr16450473wrw.61.1611843323446;
        Thu, 28 Jan 2021 06:15:23 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:a080:4cd9:70a6:2d2])
        by smtp.gmail.com with ESMTPSA id l14sm6792371wrq.87.2021.01.28.06.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 06:15:22 -0800 (PST)
Date:   Thu, 28 Jan 2021 14:15:21 +0000
From:   Alessio Balsini <balsini@android.com>
To:     qxy <qxy65535@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V12 2/8] fuse: 32-bit user space ioctl compat for
 fuse device
Message-ID: <YBLG+QlXqVB/bo/u@google.com>
References: <20210125153057.3623715-1-balsini@android.com>
 <20210125153057.3623715-3-balsini@android.com>
 <CAMAHBGzkfEd9-1u0iKXp65ReJQgUi_=4sMpmfkwEOaMp6Ux7pg@mail.gmail.com>
 <YBFtXqgvcXW5fFCR@google.com>
 <CAMAHBGwpKW+30kNQ_Apt8A-FTmr94hBOzkT21cjEHHW+t7yUMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMAHBGwpKW+30kNQ_Apt8A-FTmr94hBOzkT21cjEHHW+t7yUMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I'm more than happy to change the interface into something that is
objectively better and accepted by everyone.
I would really love to reach the point at which we have a "stable-ish"
UAPI as soon as possible.

I've been thinking about a few possible approaches to fix the issue, yet
to preserve its flexibility. These are mentioned below.


  Solution 1: Size

As mentioned in my previous email, one solution could be to introduce
the "size" field to allow the structure to grow in the future.

struct fuse_passthrough_out {
    uint32_t        size;   // Size of this data structure
    uint32_t        fd;
};

The problem here is that we are making the promise that all the upcoming
fields are going to be maintained forever and at the offsets they were
originally defined.


  Solution 2: Version

Another solution could be to s/size/version, where for every version of
FUSE passthrough we reserve the right to modifying the fields over time,
casting them to the right data structure according to the version.


  Solution 3: Type

Using an enumerator to define the data structure content and purpose is
the most flexible solution I can think of.  This would for example allow
us to substitute FUSE_DEV_IOC_PASSTHROUGH_OPEN with the generic
FUSE_DEV_IOC_PASSTHROUGH and having a single ioctl for any eventually
upcoming passthrough requests.

enum fuse_passthrough_type {
    FUSE_PASSTHROUGH_OPEN
};

struct fuse_passthrough_out {
    uint32_t type; /* as defined by enum fuse_passthrough_type */
    union {
        uint32_t fd;
    };
};

This last is my favorite, as regardless the minimal logic required to
detect the size and content of the struct (not required now as we only
have a single option), it would also allow to do some kind of interface
versioning (e.g., in case we want to implement
FUSE_PASSTHROUGH_OPEN_V2).

What do you think?

Thanks,
Alessio

P.S.
Sorry if you received a duplicate email. I first sent this in reply to an email
without realizing it was a private message.

On Thu, Jan 28, 2021 at 11:01:59AM +0800, qxy wrote:
> Hi Alessio,
> 
> I have received a failure from the Mail Delivery System for times and feel
> really sorry if you have already received the duplicate message...
> 
> Thank you for your reply.
> I think it's wonderful to remove *vec from the data structure fields since
> we consider that it is not a good idea to use pointer when there is a need
> for cross-platform.
> Do you have a plan to modify the kernel fuse_passthrough_out data structure
> the same way as you mentioned?
> 
> Thanks!
> qixiaoyu
