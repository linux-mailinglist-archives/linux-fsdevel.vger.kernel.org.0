Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404653A38E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 02:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFKAh4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 20:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhFKAh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:37:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C74C0617A6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 17:35:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k22-20020a17090aef16b0290163512accedso6351484pjz.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 17:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XHEOneV6xOvgnCB9WfgoSFCEZ8op6W4928JKpNJVbTw=;
        b=M1hyMFykopfO5ZcCQkpbyvSkWTZ8tSU+lHLbZNQgzFB3JS5x2/8o4ImE9/CGQfd4bG
         XNXNPWarbyiA/yrrze7nZMCVx3TUyT8IJUwK0JCz7gCerKZlfl/436vbe+aHgrtAKOxk
         b8fWoBbtjzkeqp9JuY0vwaX3L+480yW/tBi90NlQMEad7unccZQ6RPquEYVjNGcdZ63/
         1SoyQLc6Juz1PJK42TjO6P+Q95tY7xLKOfBiB0F1omdXKLvnkl87JXsTBGdTeE8uIVKe
         Vrq6tfYX+MbHmh0KUK7+tPJmByaw5vl9Ns1MgqK7ziWLpH+RkWrlv+HdiCPmjl1T4lnf
         Fd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XHEOneV6xOvgnCB9WfgoSFCEZ8op6W4928JKpNJVbTw=;
        b=gh2vTpJrPjfCPfVS4ayX3uFOl1ojcnotUAFqFEs1Ig+qERo1ANWEiSCY1TBzwBH8EU
         8DNfhgsGFp4jkehAO6d9lJkoTVsO/1qwDhL4+jF2HGCuefxp4osiGDXHPl0dsn0hWLMX
         +ajNYC338Ds+kAU3H+A9+3/FKKZj8L0Nv48rydIdk9MjVEVJULsLWHHvS259COenTCcs
         M1VfvrD0JCQWwBdgdzyJsWEwNQltjq3R5ORTWAqCe1N1ae5/WQE4LnxwG2YFQR8xNuGY
         ryUsT+5179dFPLTM90Fc0oqJpReA0N4VFCU7KJWdAPYv9fiWHieoFxAw8hy690uU4x41
         Yszg==
X-Gm-Message-State: AOAM5320v504wbfEl25+xH0vYpWTuHos1mNKIzNZKo5fjZC83Y5oYZGO
        Z22Oxlv8P9qkP9McMlVj4N81Cw==
X-Google-Smtp-Source: ABdhPJz1cLxliItxbhFi+YXdksjv1tMjK5cQfahLZG/tmnF1+KrSTR5JcyyVbVHffPbgvM/QCmbzNA==
X-Received: by 2002:a17:90a:dc04:: with SMTP id i4mr1515932pjv.75.1623371746155;
        Thu, 10 Jun 2021 17:35:46 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:f66a:ff0e:a646:785c])
        by smtp.gmail.com with ESMTPSA id 76sm3292949pfy.82.2021.06.10.17.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 17:35:45 -0700 (PDT)
Date:   Fri, 11 Jun 2021 10:35:33 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Add pidfd support to the fanotify API
Message-ID: <YMKv1U7tNPK955ho@google.com>
References: <cover.1623282854.git.repnop@google.com>
 <CAOQ4uxgR1cSsE0JeTGshtyT3qgaTY3XwcxnGne7zuQmq00hv8w@mail.gmail.com>
 <YMG3crGB2RYZtVmf@google.com>
 <20210610113240.GC23539@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610113240.GC23539@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 01:32:40PM +0200, Jan Kara wrote:
> On Thu 10-06-21 16:55:46, Matthew Bobrowski wrote:
> > > In general, I think it is good practice to provide a test along with any
> > > fix, but for UAPI changes we need to hold higher standards - both the
> > > test and man page draft should be a must before merge IMO.
> > 
> > Agree, moving forward I will take this approach.
> > 
> > > We already know there is going to be a clause about FAN_NOPIDFD
> > > and so on... I think it is especially hard for people on linux-api list to
> > > review a UAPI change without seeing the contract in a user manual
> > > format. Yes, much of the information is in the commit message, but it
> > > is not the same thing as reading a user manual and verifying that the
> > > contract makes sense to a programmer.
> > 
> > Makes sense.
> 
> I agree with Amir that before your patches can get merged we need a manpage
> update & LTP coverage. But I fully understand your approach of trying to
> figure out how things will look like before writing the tests and manpage
> to save some adaptation of tests & doc as the code changes. For relatively
> simple changes like this one that approach is fine by me as well (for more
> complex API changes it's often easier to actually *start* with a manpage to
> get an idea where we are actually heading). I just want the tests & doc to
> be part of at least one submission so that e.g. people on linux-api have a
> good chance to review stuff without having to dive into code details.

Sure, that's not a problem. I'll get the LTP and man-pages patches also
prepared and send references through to them as part of the next version of
this series.

Thanks for all the suggestions and review!

/M
