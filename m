Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B105276075
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 20:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgIWSte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 14:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgIWSte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:49:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3841CC0613CE;
        Wed, 23 Sep 2020 11:49:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y11so779462qtn.9;
        Wed, 23 Sep 2020 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RkpPiL5sLMoQ72Z4SVPCyIzaZVEUsKD6IONs26Z9oQ4=;
        b=j6zFoRR/TNHPnYOJYg/v6yC5mOjqz6GhBvNdUdw/ZZY3Z659h4thQrXUvmYYNs/dMc
         9AtbSQc1r9/KTQ+OdnHEMcrYOKmjexHp+zLAowzXW60xVUgp32upPori8ocBAUEa2r3r
         RBgGigmHJn+mG8rh+rrSfDqq2SdthMmzakAE8uf56Ks1STHFgtkyEvVJSTmUDeKd4JlH
         Cx+3SJd1aI9By0RJ0GJTBMtFDnsq45jEHay9VWPh2LaXhf87zwX1sup1iq4GFW7bYwHN
         wYZuJxH556l/n/M+2V+a2YdPh4IkzEbo9S36Kf5zviplDX4eWHJkLL/e8sUM7P5GbZLv
         8Ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RkpPiL5sLMoQ72Z4SVPCyIzaZVEUsKD6IONs26Z9oQ4=;
        b=dUYeTO293gYaaqNb5QY1CAxzysue013cNtGWDEbX/qPCgeAuN8dX5ow7pR/MBc2qyN
         Fvlsha7nrvoddkJIVG/VQIFJWB3layfykHnz8wTsTT9xZza0zIg6BFISjdN9R0Yuh+13
         t5XilUwLTqq4NSK0jl1isZctxhr6xrHaOGzpXZPMXKFqWAAu7lF9UJMWtwwWrg3rDC6q
         IyVflyHaInlZdYFZIZ0BjEELl3UQy8pf6+lVJ227a8Cj2p81TL7jtvlFY+HoE5grPZaZ
         tTd6tlsrgSr2C3Z62MFmI6lGRVulvElWrsUmDzQija7gQfl5Rp4ZUB9tBiwmDY2yVV/7
         oePg==
X-Gm-Message-State: AOAM531c8/RUS3QgJnipt9vrddG/HBzvwgqbUD5Fq6kMG0a8QN+Yox69
        6rLqmahsS0W6uU9jpD2jRMSNTLsmOPw=
X-Google-Smtp-Source: ABdhPJwkH8cFnD08Pdj7anSenqn2tvNw6QetwTg2I4xIrVuO/X572JBB17yMeOLN0zGx1aVaPRH8zA==
X-Received: by 2002:aed:3203:: with SMTP id y3mr1556830qtd.278.1600886973396;
        Wed, 23 Sep 2020 11:49:33 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r187sm518764qkc.63.2020.09.23.11.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 11:49:32 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 23 Sep 2020 14:49:30 -0400
To:     Solar Designer <solar@openwall.com>
Cc:     Florian Weimer <fweimer@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        madvenka@linux.microsoft.com, kernel-hardening@lists.openwall.com,
        linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        mark.rutland@arm.com, mic@digikod.net,
        Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200923184930.GA1352963@rani.riverdale.lan>
References: <20200922215326.4603-1-madvenka@linux.microsoft.com>
 <20200923081426.GA30279@amd>
 <20200923091456.GA6177@openwall.com>
 <87wo0ko8v0.fsf@oldenburg2.str.redhat.com>
 <20200923181136.GA8846@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923181136.GA8846@openwall.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 08:11:36PM +0200, Solar Designer wrote:
> On Wed, Sep 23, 2020 at 04:39:31PM +0200, Florian Weimer wrote:
> > * Solar Designer:
> > 
> > > While I share my opinion here, I don't mean that to block Madhavan's
> > > work.  I'd rather defer to people more knowledgeable in current userland
> > > and ABI issues/limitations and plans on dealing with those, especially
> > > to Florian Weimer.  I haven't seen Florian say anything specific for or
> > > against Madhavan's proposal, and I'd like to.  (Have I missed that?)
> 
> [...]
> > I think it's unnecessary for the libffi use case.
> [...]
> 
> > I don't know if kernel support could
> > make sense in this context, but it would be a completely different
> > patch.
> 
> Thanks.  Are there currently relevant use cases where the proposed
> trampfd would be useful and likely actually made use of by userland -
> e.g., specific userland project developers saying they'd use it, or
> Madhavan intending to develop and contribute userland patches?
> 
> Alexander

The trampoline it provides in this version can be implemented completely
in userspace. The kernel part of it is essentially just providing a way
to do text relocations without needing a WX mapping, but the text
relocations would be unnecessary in the first place if the trampoline
was position-independent code.
