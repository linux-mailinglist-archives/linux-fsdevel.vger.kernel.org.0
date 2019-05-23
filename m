Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22DF32800A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbfEWOnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 10:43:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36718 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfEWOnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 10:43:50 -0400
Received: by mail-io1-f66.google.com with SMTP id e19so5059837iob.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zr03PxvX3Q9baWaHps2wF9f+lJL+gPYP1/+9lyUaWfw=;
        b=FnGZ0kJDfcg3DpNlDaDqLOqGHCVxeW7Xbx05UK/GNeTp+jzBg1cJQzSi6TFvzSf+Wg
         q9a8fbh90aVA/Fiu5cVrla6U97izAFOwfKBWvXT2sgXkrYftUXiCUUieEMvsHNFtV23J
         XunntKmp8TiJXk2EnUB8daKeCTHV54IZdsoEUTDEXTpN3wrqx5k9Y8CvJgTo+PsxF5IV
         DN/7CESAYvoQt/sYpjH1i8k6XA4FNBtlSBC5R3+L/00kaddmDV/RU3WvwZSchWELskeY
         5meY+WjAbL1ZPXH3ATdgEzHM+2oqhtU1duMBHKH89W12BjYwJnChp18ZL3kjtQaaoKi0
         7jXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zr03PxvX3Q9baWaHps2wF9f+lJL+gPYP1/+9lyUaWfw=;
        b=HiEcUtd6f4rf4U4OeAykvHnGChbxgiwGX/MQsLhD0F4Lc1DVGYVlVjoA+Giq/XX/QN
         0cLpPTtEhTTYakWAgKpBHe6NS8LR2rqMLhmQneGON0Lul/stxKbHI4kOG5Y6AK0qUnef
         52MTlXGBSbAWFO+luWqR8xv4EYNsfi6BvVT+DxOrxXGUGp6p6NRS1mjnr/6i6Rr2DKsq
         OJe42fSQlMKDzMsCgRO4TZByjvZ+hZyt8vIwRNxK37Oxjy6HGvIlKWNNe0PWNA50fHR5
         kHbFci7i8CO2DsmuVLilv8TeIDNLc1qy8e7M2WdBA12+b79fC+jHE7j7Qvm+g58Pke2x
         19mA==
X-Gm-Message-State: APjAAAXIsndkN9A/EhSjHuG4x3sa+iEJUczPcf4g8QQYGh5xXfnFQuIx
        XIp4jPIwq+gi70tStCXBV3S0pPPMpUDF4g==
X-Google-Smtp-Source: APXvYqzn9fD6jIUuMkhV+I8qPXKpA0lebAcJZNoO4nnL5N3JWDsHHACUYc+tQ0/wanRBkCmQlWSJlw==
X-Received: by 2002:a5d:8589:: with SMTP id f9mr14216938ioj.274.1558622629386;
        Thu, 23 May 2019 07:43:49 -0700 (PDT)
Received: from brauner.io ([172.56.12.187])
        by smtp.gmail.com with ESMTPSA id b142sm4336118itb.28.2019.05.23.07.43.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 07:43:48 -0700 (PDT)
Date:   Thu, 23 May 2019 16:43:43 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
Message-ID: <20190523144342.5ty2v3zxaezkq4vf@brauner.io>
References: <EB97EF04-D44F-4320-ACDC-C536EED03BA4@brauner.io>
 <CAOQ4uxhodqVw0DVfcvXYH5vBf4LKcv7t388ZwXeZPBTcEMzGSw@mail.gmail.com>
 <20190523095506.nyei5nogvv63lm4a@brauner.io>
 <CAOQ4uxiBeAzsE+b=tE7+9=25-qS7ohuTdEswYOt8DrCp6eAMuw@mail.gmail.com>
 <20190523104239.u63u2uth4yyuuufs@brauner.io>
 <CAOQ4uxji4jRvJnLvXe0yR4Ls7VxM_tjAypX1TqBe5FYr_7GnXw@mail.gmail.com>
 <20190523115845.w7neydaka5xivwyi@brauner.io>
 <CAOQ4uxgJXLyZe0Bs=q60=+pHpdGtnCdKKZKdr-3iTbygKCryRA@mail.gmail.com>
 <20190523133516.6734wclswqr6vpeg@brauner.io>
 <20190523144050.GE2949@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523144050.GE2949@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 04:40:50PM +0200, Jan Kara wrote:
> On Thu 23-05-19 15:35:18, Christian Brauner wrote:
> > So let's say the user tells me:
> > - When the "/A/B/C/target" file appears on the host filesystem,
> >   please give me access to "target" in the container at a path I tell
> >   you.
> > What I do right now is listen for the creation of the "target" file.
> > But at the time the user gives me instructions to listen for
> > "/A/B/C/target" only /A might exist and so I currently add a watch on A/
> > and then wait for the creation of B/, then wait for the creation of C/
> > and finally for the creation of "target" (Of course, I also need to
> > handle B/ and C/ being removed again an recreated and so on.). It would
> > be helpful, if I could specify, give me notifications, recursively for
> > e.g. A/ without me having to place extra watches on B/ and C/ when they
> > appear. Maybe that's out of scope...
> 
> I see. But this is going to be painful whatever you do. Consider for
> example situation like:
> 
> mkdir -p BAR/B/C/
> touch BAR/B/C/target
> mv BAR A
> 
> Or even situation where several renames race so that the end result creates
> the name (or does not create it depending on how renames race). And by the
> time you decide A/B/C/target exists, it doesn't need to exist anymore.
> Honestly I don't see how you want to implement *any* solution in a sane
> way. About the most reliable+simple would seem to be stat "A/B/C/target"
> once per second as dumb as it is.

What we have kinda works rn good enough. And yes, it's inherently racy.
Basically, iirc we only watch that it exists once, then create the thing
for the container and then consider our job done. If that thing is
removed under us we don't really care.

Christian
