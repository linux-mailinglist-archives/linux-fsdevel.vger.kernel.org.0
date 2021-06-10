Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C663A24D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 08:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFJG6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 02:58:55 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:46622 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJG6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:58:54 -0400
Received: by mail-pj1-f50.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso3204637pjb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jun 2021 23:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2aDtXE7kDwDYcnw1DjmnkRw8CyFdvtQ3yMA1h6IvAQg=;
        b=mYoNlVCax049SKFZoh13ufk31j20rFC1095QG4YB8JO6fPhjRaFzIsD5C1PtEjqgj+
         +dL7mbcki5gbyzQXRohncg/8iGGrSrkRNxqm5SgQmoANlkdLfs2zL9J2cKyHrXPCr3i+
         79LsrQQ6H58GmN0SlP2t9ldB4fWhemWFH6Gq5JTglUvfJPDpmx06d6TWbiQk6UMGny0/
         TcChl/XMznVzxT9QPDewGv/VpZCQ+ZRHlmerRgJGpfY8wLKp7VTQP6muG7+6/f0auegz
         82J9obZ9DCo7vXh692fzDcIc+fHRLJI9fyrsX7IU4Wru28Kpf2of5YFvR2EzCXwklKQZ
         pszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2aDtXE7kDwDYcnw1DjmnkRw8CyFdvtQ3yMA1h6IvAQg=;
        b=U6mFCMieSP4rD9yOCmgvjhrlkPjolrVzb9WLTAsn3AFrgaLYeFh4YDd90uGQ8g01OH
         l+D9rswRHK0qSi5mG3FdtgfZpIxTfVUu05p44OPEf3YZDikYbfL4S1/7JO2xU0Qk57Lv
         7ISICydruhizY5LkLZIFHNFcjtWRGKuDzsG/PJxzrwZ01nEgPmsQlrdv1YCFzZ5Uoi44
         FZLgu7O5JQmi+Yb7oWlZzf2yXRhCYOY5fEymqG1TJzTA4XEJzab9eTT1/WXQE8bg8jGt
         zPr/SQcCLqGg9gnm0WqeIHAhbJQS8pGwluDeJQW1As8wXnHBfXC0moCOUmfoHEQzozCg
         fZJg==
X-Gm-Message-State: AOAM530bHjCjDBzAHOJYmF5E6HTqPPsBJIQJKF26BD2xm5jWShoAsUCp
        /w2OofBcnBawrEFVBJ3wVZMzOQ==
X-Google-Smtp-Source: ABdhPJwnjY/iRVP5AKb8AM0J04xj7JCoATvoyOAwG+BoREk4gF/66U9HJyirJcaOR+FBsHqGcxCwoQ==
X-Received: by 2002:a17:902:8a83:b029:10f:45c4:b435 with SMTP id p3-20020a1709028a83b029010f45c4b435mr3361949plo.17.1623308158698;
        Wed, 09 Jun 2021 23:55:58 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:6512:d64a:3615:dcbf])
        by smtp.gmail.com with ESMTPSA id a11sm1513981pjq.45.2021.06.09.23.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:55:58 -0700 (PDT)
Date:   Thu, 10 Jun 2021 16:55:46 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Add pidfd support to the fanotify API
Message-ID: <YMG3crGB2RYZtVmf@google.com>
References: <cover.1623282854.git.repnop@google.com>
 <CAOQ4uxgR1cSsE0JeTGshtyT3qgaTY3XwcxnGne7zuQmq00hv8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgR1cSsE0JeTGshtyT3qgaTY3XwcxnGne7zuQmq00hv8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the review Amir, appreciated as always.

On Thu, Jun 10, 2021 at 08:37:19AM +0300, Amir Goldstein wrote:
> On Thu, Jun 10, 2021 at 3:19 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > Hey Jan/Amir/Christian,
> >
> > Sending through v2 of the fanotify pidfd patch series. This series
> > contains the necessary fixes/suggestions that had come out of the
> > previous discussions, which can be found here [0], here [1], and here
> > [3].
> >
> > The main difference in this series is that we perform pidfd creation a
> > little earlier on i.e. in copy_event_to_user() so that clean up of the
> > pidfd can be performed nicely in the event of an info
> > generation/copying error. Additionally, we introduce two errors. One
> > being FAN_NOPIDFD, which is supplied to the listener in the event that
> > a pidfd cannot be created due to early process termination. The other
> > being FAN_EPIDFD, which will be supplied in the event that an error
> > was encountered during pidfd creation.
> >
> >   kernel/pid.c: remove static qualifier from pidfd_create()
> >   kernel/pid.c: implement additional checks upon pidfd_create()
> >     parameters
> >   fanotify/fanotify_user.c: minor cosmetic adjustments to fid labels
> >   fanotify/fanotify_user.c: introduce a generic info record copying
> >     helper
> 
> Above fanotify commits look good to me.
> Please remove /fanotify_user.c from commit titles and use 'pidfd:' for
> the pidfd commit titles.

OK, noted for the next series. Thanks for the pointers.

> >   fanotify: add pidfd support to the fanotify API
> >
> 
> This one looks mostly fine. Gave some minor comments.
> 
> The biggest thing I am missing is a link to an LTP test draft and
> man page update draft.

Fair point, the way I approached it was that I'd get the ACK from all of
you on the overall implementation and then go ahead with providing
additional things like LTP and man-pages drafts, before the merge is
performed.

> In general, I think it is good practice to provide a test along with any
> fix, but for UAPI changes we need to hold higher standards - both the
> test and man page draft should be a must before merge IMO.

Agree, moving forward I will take this approach.

> We already know there is going to be a clause about FAN_NOPIDFD
> and so on... I think it is especially hard for people on linux-api list to
> review a UAPI change without seeing the contract in a user manual
> format. Yes, much of the information is in the commit message, but it
> is not the same thing as reading a user manual and verifying that the
> contract makes sense to a programmer.

Makes sense.

/M
