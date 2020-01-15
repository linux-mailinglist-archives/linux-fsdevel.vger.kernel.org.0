Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D4F13C5E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 15:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgAOOYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 09:24:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37481 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgAOOYc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:24:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so44831wmf.2;
        Wed, 15 Jan 2020 06:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/cV4Dosms8WVB2oaAlg7z/oFwAecJU/lIwjN6rGAxM8=;
        b=bVvlc4q8m8fhK0Z9DySQFpKNp6uE8a9NG/bVO5p6RoTPSFGT18+CVCybpNpmxjkCRk
         DM8inpDxNv5gzVK8mV/ptdfNwHPjW8FJFSOIx+5nzWdGwdyC4u34KU+gfzSCM5yYQShp
         dT9Aj+aPX/wav9Wc8s2Bh6pH1gZYSGgwpnB8BPBnfdrNxS1Q7ZLDPIdXvcoKgeRZEKiq
         z7hha2oGjhjAMRotvZYt9gA8VuV8aK2qrxzA5bHWNPbA/KW8Bkcyz/PvLsEXzSOXFgNY
         hqsy8FfA+80kEu37WvXFFtkZk4gvZ0KZNYVSuifWRxO+N5gFe22oZGrW5HC7tgPQEZSq
         TPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/cV4Dosms8WVB2oaAlg7z/oFwAecJU/lIwjN6rGAxM8=;
        b=crB4sbTOl5pl8kppQdXMJ6QU+oVi1Dcy1ciwg2I+YD3xxXLlrg1j4qI1lZakl1Ge1h
         8Yvsi02j3/YoPPiwMAYH4lmmeY2JOZ61fTL6kDwVLf2pXnQPu9CbMQDhy6/8hup/ROaS
         A6wZBSwUIRvBhmZzSFKlrV7cgyUBOcL0R/a4Vk5WBvUD4oZWjoGihZr/F63cqMA/U9tv
         U4V1y/4D6E89cze+h4tN3BnZGygxVWI0YQQQLT87lqE0Z9aerLPbD74vOxFH8G55fvVF
         rVWKdRFOu78WtrSwv7Sc8ZQpeXxF3GDR8V6HZVIfiQJwIuQ9dxk6+T7e945uhfzcjA9U
         xGfg==
X-Gm-Message-State: APjAAAW532U3sCC4GlPwBkKTznCOS1joA0NyOblFcMfl+tICWtX4Zk0k
        bIhBANk2VTs+hILWNuMD07g=
X-Google-Smtp-Source: APXvYqxTwabGn05HpEh7ACRTNrjX9YrY1gcLlaH7ueZdUinow1DSehKVBJkyalyeYPRke/izr14LYg==
X-Received: by 2002:a7b:cb0d:: with SMTP id u13mr35307563wmj.31.1579098269992;
        Wed, 15 Jan 2020 06:24:29 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v8sm23733273wrw.2.2020.01.15.06.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:24:29 -0800 (PST)
Date:   Wed, 15 Jan 2020 15:24:28 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Namjae Jeon <linkinjeon@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com
Subject: Re: [PATCH v10 09/14] exfat: add misc operations
Message-ID: <20200115142428.ugsp3binf2vuiarq@pali>
References: <CGME20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com>
 <20200115082447.19520-10-namjae.jeon@samsung.com>
 <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
 <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com>
 <20200115133838.q33p5riihsinp6c4@pali>
 <CAK8P3a1ozgLYpDtveU0CtLj5fEFG8i=_QrnEAtoVFt-yC=Dc0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1ozgLYpDtveU0CtLj5fEFG8i=_QrnEAtoVFt-yC=Dc0g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 15 January 2020 14:50:10 Arnd Bergmann wrote:
> On Wed, Jan 15, 2020 at 2:38 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > On Wednesday 15 January 2020 22:30:59 Namjae Jeon wrote:
> > > 2020-01-15 19:10 GMT+09:00, Arnd Bergmann <arnd@arndb.de>:
> 
> > > It is not described in the specification. I don't know exactly what
> > > the problem is because sys_tz.tz_minuteswest seems to work fine to me.
> > > It can be random garbage value ?
> > >
> > > > so if there is a choice, falling back to UTC would
> > > > be nicer.
> > >
> > > Okay.
> >
> > Arnd, what is the default value of sys_tz.tz_minuteswest? What is the
> > benefit of not using it?
> >
> > I though that timezone mount option is just an old hack when userspace
> > does not correctly set kernel's timezone and that this timezone mount
> > option should be in most cases avoided.
> 
> The main problem is that it is system-wide and initialized at boot
> time through settimeofday() to a timezone picked by the system
> administrator.
> 
> However, in user space, every user may set their own timezone with
> the 'TZ' variable, and the default timezone may be different inside of a
> container based on the contents of /etc/timezone in its root directory.

So kernel timezone is shared across all containers, right?

> > So also another question, what is benefit of having fs specific timezone
> > mount option? As it is fs specific it means that it would be used so
> > much.
> 
> You can use it to access removable media that were written in
> a different timezone or a partition that is shared with another OS
> running on the same machine but with different timezone settings.

So... basically all userspace <--> kernel API which works with timestamp
do not have information about timezone right? creat(), utime() or
utimensat() just pass timestamp without timezone information. Is this
timestamp mean to be in UTC or in local user time zone (as specified by
user's TZ= env variable)?

-- 
Pali Rohár
pali.rohar@gmail.com
