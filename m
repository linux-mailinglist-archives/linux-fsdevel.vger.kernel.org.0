Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7127D3F2D49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 15:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhHTNmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 09:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232399AbhHTNmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629466896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KjTjMbm6Ax2NoBz/SV8LRb7ROzLCYCzwIW7Ojvzm8c=;
        b=Jt9XdDQWyH03r53TGp7ek1/rLaiq8705bB71BbhphDbX6DR6exhFcD/k5CdvcK2w94qCa7
        o3uwotybcnEUXSjzt2w6w83EmxsecZhroo51fN7S54L3lfxOiEo2x59RguoPAzix6nNF4l
        kP7J+XrN9sGBUq47Yn1bVxDYJwPG3VA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-aUp8tXjEPxaeOJifxj4ftQ-1; Fri, 20 Aug 2021 09:41:34 -0400
X-MC-Unique: aUp8tXjEPxaeOJifxj4ftQ-1
Received: by mail-ej1-f71.google.com with SMTP id bx10-20020a170906a1ca00b005c341820edeso792283ejb.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 06:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=4KjTjMbm6Ax2NoBz/SV8LRb7ROzLCYCzwIW7Ojvzm8c=;
        b=JtcTPh1/bNq0FrC1RQk2vGTIRKgxdmlOuqAktEXXW7NlIzGkxNE5zk0813YNsYXnnS
         LAV+pYB4BxZigU09kPMQfvcJYhh0aBmtnliUuur+BjgzNEMwqbTnlJuvkIXcLqKbt9DM
         O6BVBheCdqKZMwnN+6M+3BkGFbIsQhH7udnEQSbueFbHUjowPqsNIvYepnSQ3e+A2qy8
         hwjCnymQSas7c8teUGe3xNQM46PrvfoihgiG+mAKV4pvppuHHVsLhZacTV8JfjAr406Y
         +/LyvDmXH5tbKd8YK1iIr/R2ZeiCY2+NITG/nUh9xNH9558MHxk9fYDjUeCfyv38l3y1
         PDAA==
X-Gm-Message-State: AOAM531/sYfDU1SQW7+fgvyARoRaB8Dk4J8eVbCmSfsS0zzcJF5piIk5
        +LFIn5pJVvmknBpEBxeHRr88P3CGE0cEHwJW/q0/zte/BhDVhs/EsLMkpnkBgXoz4MMzziM/gjs
        yKUGAC62SkB13L8GqR+8dT4C7iA==
X-Received: by 2002:aa7:db8b:: with SMTP id u11mr22178962edt.362.1629466893415;
        Fri, 20 Aug 2021 06:41:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0hLwN+s7rk8F847DLOmn4dy1Ao93kGJxxgV8+oY8fbxG+6Lejz40d6vR1Ye9lqW0fsphjXg==
X-Received: by 2002:aa7:db8b:: with SMTP id u11mr22178939edt.362.1629466893221;
        Fri, 20 Aug 2021 06:41:33 -0700 (PDT)
Received: from 0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa (0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:ffda:0:2059:8730:b2:c370])
        by smtp.gmail.com with ESMTPSA id g14sm3636121edr.47.2021.08.20.06.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 06:41:32 -0700 (PDT)
Message-ID: <2508f12f0d2a5eedaad0c6b77657f53222b33e3c.camel@redhat.com>
Subject: Re: [Cluster-devel] [PATCH v6 10/19] gfs2: Introduce flag for glock
 holder auto-demotion
From:   Steven Whitehouse <swhiteho@redhat.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Date:   Fri, 20 Aug 2021 14:41:32 +0100
In-Reply-To: <cf284633-a9db-9f88-6b60-4377bc33e473@redhat.com>
References: <20210819194102.1491495-1-agruenba@redhat.com>
         <20210819194102.1491495-11-agruenba@redhat.com>
         <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com>
         <cf284633-a9db-9f88-6b60-4377bc33e473@redhat.com>
Organization: Red Hat UK Ltd
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Fri, 2021-08-20 at 08:11 -0500, Bob Peterson wrote:
> On 8/20/21 4:35 AM, Steven Whitehouse wrote:
> > Hi,
> > 
> > On Thu, 2021-08-19 at 21:40 +0200, Andreas Gruenbacher wrote:
> > > From: Bob Peterson <rpeterso@redhat.com>
> > > 
> > > This patch introduces a new HIF_MAY_DEMOTE flag and
> > > infrastructure
> > > that
> > > will allow glocks to be demoted automatically on locking
> > > conflicts.
> > > When a locking request comes in that isn't compatible with the
> > > locking
> > > state of a holder and that holder has the HIF_MAY_DEMOTE flag
> > > set,
> > > the
> > > holder will be demoted automatically before the incoming locking
> > > request
> > > is granted.
> > > 
> > I'm not sure I understand what is going on here. When there are
> > locking
> > conflicts we generate call backs and those result in glock
> > demotion.
> > There is no need for a flag to indicate that I think, since it is
> > the
> > default behaviour anyway. Or perhaps the explanation is just a bit
> > confusing...
> 
> I agree that the whole concept and explanation are confusing.
> Andreas 
> and I went through several heated arguments about the symantics, 
> comments, patch descriptions, etc. We played around with many
> different 
> flag name ideas, etc. We did not agree on the best way to describe
> the 
> whole concept. He didn't like my explanation and I didn't like his.
> So 
> yes, it is confusing.
> 
That seems to be a good reason to take a step back and look at this a
bit closer. If we are finding this confusing, then someone else looking
at it at a future date, who may not be steeped in GFS2 knowledge is
likely to find it almost impossible.

So at least the description needs some work here I think, to make it
much clearer what the overall aim is. It would be good to start with a
statement of the problem that it is trying to solve which Andreas has
hinted at in his reply just now,

Steve.


