Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73B1902B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 01:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgCXAQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 20:16:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43616 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgCXAQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:16:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id bd14so4774152edb.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2020 17:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/2Y64PABVXdc9ONlMpskyvi+SAnumMA7Crj5Bt/DBQ=;
        b=Pw/jLYEtjS/ATrpjcImP2D5HPDWiFMBcBAxJVSOwIOaspT/epTOM9IydWFzxho9yua
         oazmW6QWguLgtIbfTk74PkycIDjFDPzKqyzaoh+DhJAVrmkuDU/uAM53LPP8DVs9E40Q
         tUZMoTzJY+STJT3ur0XbLBaDl6VIvIN8N0+HMJRRBPnxJx3Fysg9dQsHduc19AT8XqUR
         Z+R5dqyHsad39E8wBrmCN6RWKFaLpPh9SfxtI2Y1DRQLG2Yf+1AwZidHAvD5ViWXYqSy
         a907RgFuMp40UgoEATMPqB/Btt7FRTYbwdl5UG8XBt+aLoRiYnvjPwNK2Qw9OiPVrwLO
         +WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/2Y64PABVXdc9ONlMpskyvi+SAnumMA7Crj5Bt/DBQ=;
        b=hCSxWyDs4lNTBvfbxawuBb3GyJG1vxh+2+BV5NukSBB+GFou3P4w81xclKE5A8Gn9J
         UojhW/6twzhD10TsSNBOPpnY8HxDCRx+jspuG9rb+nlV8PzvL8xnpofaSRMia9T2/Fbm
         Lq18OujzNUAx8xaD+Lsl2s6Vf3gW5oZFbkyweImz24Uv8JyvxMIUdWg1SrnVJGHqUEoo
         8RMizqoetTsS9NPvdKCoB+hO/fyUa5qIlnI9UdQzhUYGBHXMWq+spE6MAxZ6sYmWmnbj
         8LRTCPZNCZYlrvqPRRjuQuJP6f4iWP0pzFZx9aguT/Voh6njfJuZr4rw9GypZ24qrmAI
         1zwQ==
X-Gm-Message-State: ANhLgQ3OH25hnGJGnwTHiQ8geSCg3c7642MCVdoADTbkZIDXKOWsBOQ7
        sukcUjhwBjHOXVQ+PIOtso9mGnKw6YlObGCCDCDL
X-Google-Smtp-Source: ADFU+vsjQok/w3GcfT1LJO6k41X3syl3c/RCvqnEbN1LGDpZdSJHQ9PBkLkvozzz1CLw+59ARBWSon4cJDwpW8rrY9U=
X-Received: by 2002:a17:906:4b52:: with SMTP id j18mr13098102ejv.272.1585009010419;
 Mon, 23 Mar 2020 17:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTiCHQbp2SwK0Xb1QgpUZxOQ26JKKPsVGT0ZvMqx28oPQ@mail.gmail.com>
 <CAHC9VhS09b_fM19tn7pHZzxfyxcHnK+PJx80Z9Z1hn8-==4oLA@mail.gmail.com>
 <20200312193037.2tb5f53yeisfq4ta@madcap2.tricolour.ca> <CAHC9VhQoVOzy_b9W6h+kmizKr1rPkC4cy5aYoKT2i0ZgsceNDg@mail.gmail.com>
 <20200313185900.y44yvrfm4zxa5lfk@madcap2.tricolour.ca> <CAHC9VhR2zCCE5bjH75rSwfLC7TJGFj4RBnrtcOoUiqVp9q5TaA@mail.gmail.com>
 <20200318212630.mw2geg4ykhnbtr3k@madcap2.tricolour.ca> <CAHC9VhRYvGAru3aOMwWKCCWDktS+2pGr+=vV4SjHW_0yewD98A@mail.gmail.com>
 <20200318215550.es4stkjwnefrfen2@madcap2.tricolour.ca> <CAHC9VhSdDDP7Ec-w61NhGxZG5ZiekmrBCAg=Y=VJvEZcgQh46g@mail.gmail.com>
 <20200319220249.jyr6xmwvflya5mks@madcap2.tricolour.ca>
In-Reply-To: <20200319220249.jyr6xmwvflya5mks@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Mar 2020 20:16:38 -0400
Message-ID: <CAHC9VhR84aN72yNB_j61zZgrQV1y6yvrBLNY7jp7BqQiEDL+cw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 07/16] audit: add contid support for signalling
 the audit daemon
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
        nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 19, 2020 at 6:03 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-03-18 18:06, Paul Moore wrote:

...

> > I hope we can do better than string manipulations in the kernel.  I'd
> > much rather defer generating the ACID list (if possible), than
> > generating a list only to keep copying and editing it as the record is
> > sent.
>
> At the moment we are stuck with a string-only format.

Yes, we are.  That is another topic, and another set of changes I've
been deferring so as to not disrupt the audit container ID work.

I was thinking of what we do inside the kernel between when the record
triggering event happens and when we actually emit the record to
userspace.  Perhaps we collect the ACID information while the event is
occurring, but we defer generating the record until later when we have
a better understanding of what should be included in the ACID list.
It is somewhat similar (but obviously different) to what we do for
PATH records (we collect the pathname info when the path is being
resolved).

-- 
paul moore
www.paul-moore.com
