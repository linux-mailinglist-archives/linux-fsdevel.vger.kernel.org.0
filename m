Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A795613DF78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 17:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgAPQAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 11:00:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38580 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAPQAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:00:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so4368099wmc.3;
        Thu, 16 Jan 2020 08:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Qes5lqTpMZNbHD18QpVEHmgxWIqC3UwSuESKVsX72FE=;
        b=gdJbrNwdSuD/lvrwJ+3fpsgkxvDd6PxZ5jdXHxxFu/eilWk//S1GI0gBerZequfBEj
         326Y8S+FlQEFWKuxDy9lZQugKLnfV4JoHULipF5ws+4XsNU8Sqc6ewx62CRqFL84MGp8
         qv9dxn5oq7nP57h2XPv18cQqQn9pkYxmxH/PvkOeVJ1s21/FwAHuZCzzH6EjlWqmQ3y6
         vZOqeJS/0QO7EYpjKhSFkRXflmExCP3OympCZzie+J8heuKYvrlbzNpeyx3R8CdUWknm
         gNj5I32G/uDMcheI4wyIDMWdNXeiNFuPR0jp1S49Zfa3UBnDA4NFCbqn3WIPvYWJAWQ4
         lGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qes5lqTpMZNbHD18QpVEHmgxWIqC3UwSuESKVsX72FE=;
        b=SLMPPYJVQpiDAcGQ5eayUMV6jE7o/Nsg51Hi4dPcq43v++NxXCJAI2vekK7FleSNdW
         XtC/gWEiSKW8ZAEyXyqv3O9vMcoayBZau5ke1ibgC/Dmiy17sAp7/h1jjWwnJ6jNQiYR
         kVbsUg8dp0C62zhW3KWSDieYm9H4bPRm2MQ0w2WwgAwgGftDtnJ6cmRonIDc/Derljsu
         X5nGcRYQfVRDjKTga93EmBQpwb+ZteXkUz7vmFRVDhKjCIxtAkeQVsgYslIMkYemKagR
         TsLHy1G+3uYnl11q2Mi/riu2yLZ3fkNQQGNwTyT1n2DskKoKuf6fHlhyxiI0YmARWOy1
         Ohvg==
X-Gm-Message-State: APjAAAVrKfbyfVT/qGQXxrC5olLM1rAnjI/xmlTNXjRSr2M/6Bg5Hm6w
        9Ktd300IGTcS7Y/z6mwnl18=
X-Google-Smtp-Source: APXvYqxCKtH+zs0uDEdCBM/xP9ElsKv0y4WnMKlghvorw44FNmlHzSJdTk80Pt4IhCwFHxbeFidbEQ==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr7276001wmg.66.1579190453136;
        Thu, 16 Jan 2020 08:00:53 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id 25sm4961535wmi.32.2020.01.16.08.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:00:52 -0800 (PST)
Date:   Thu, 16 Jan 2020 17:00:51 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Namjae Jeon <linkinjeon@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        sj1557.seo@samsung.com
Subject: Re: [PATCH v10 09/14] exfat: add misc operations
Message-ID: <20200116160051.adn7j7y5oshoe7qt@pali>
References: <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
 <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com>
 <20200115133838.q33p5riihsinp6c4@pali>
 <CAK8P3a1ozgLYpDtveU0CtLj5fEFG8i=_QrnEAtoVFt-yC=Dc0g@mail.gmail.com>
 <20200115142428.ugsp3binf2vuiarq@pali>
 <CAK8P3a0_sotmv40qHkhE5M=PwEYLuJfX+uRFZvh9iGzhv6R6vw@mail.gmail.com>
 <20200115153943.qw35ya37ws6ftlnt@pali>
 <CAK8P3a1iYPA9MrXORiWmy1vQGoazwHs7OfPdoHLZLJDWqu9jqA@mail.gmail.com>
 <20200116101947.4szdyfwpyasv5vpe@pali>
 <20200116102307.GA16662@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200116102307.GA16662@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 16 January 2020 11:23:07 Christoph Hellwig wrote:
> On Thu, Jan 16, 2020 at 11:19:47AM +0100, Pali Rohár wrote:
> >   However, implementations should only record the value 00h for this
> >   field when:
> > 
> >     1. Local date and time are actually the same as UTC, in which case
> >        the value of the OffsetValid field shall be 1
> > 
> >     2. Local date and time are not known, in which case the value of the
> >        OffsetValid field shall be 1 and implementations shall consider
> >        UTC to be local date and time
> 
> Given time zones in Linux are per session I think our situation is
> somewhat similar to 2.

Seems that 2. is really similar. Ok, storing by default in UTC make
sense, but still I'm thinking if there should be (or not) a mount option
which override default UTC timezone.

> > > Here I would just convert to UTC, which is what we store in the
> > > in-memory struct inode anyway.
> > 
> > Ok. If inode timestamp is always in UTC, we should do same thing also
> > for exFAT.
> 
> > Hm... both UTC and sys_tz have positives and negatives. And I'm not
> > sure which option is better.
> 
> The one big argument for always UTC is simplicity.  Always using UTC
> kills some arcane an unusual (for Linux file systems) code, and given
> how exfat implementations deal with the time zone on reading should
> always interoperate fine with other implementations.

Now I think that using UTC by default is the better option as sys_tz.
Simplicity and "no surprise" (container may use UTC, but kernel has
sys_tz in not in UTC) seems like a good arguments.

-- 
Pali Rohár
pali.rohar@gmail.com
