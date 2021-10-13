Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EF042CA23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 21:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbhJMTf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 15:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhJMTf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:35:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6448C061570;
        Wed, 13 Oct 2021 12:33:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r18so11913416wrg.6;
        Wed, 13 Oct 2021 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pwxg+EuC2BMAlI0PMqoPGlNZutsjAEU++EUzVtemrlI=;
        b=fRuQmKoz2RAOV1ENMnnv6ijypTcOqEEEsZGjCVfrdKYnpjqHpT5g1pekFTVn7yvJtO
         /x4VkUp67Akxrz3uwQ7jlDM8oc6CIt5g0b+v2myJAA4Gg3JtxO88PCREP5FW/rzOEIIK
         gxg9OQAxee2SsyJwQ63+aIQQkCOgC0+OOo5bdnwFRJv3KXvzFaXArAQkFD5niuiT3c5G
         KzQh9OtwaVUqhhgQ15gqfJSC6uEfwqjt+nkHUekxDp3QuZKJNAHDF3X2PeucwMB+n4OG
         0UVl2En0miZAbmKXq3l39jYmG5tx80B5NN6PfBPqTar66s/xOqVJa0xRRgaJpUVdd0HT
         Mnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pwxg+EuC2BMAlI0PMqoPGlNZutsjAEU++EUzVtemrlI=;
        b=QD1Pyza1N8sW3A0E6VzYQ07cruBT3F0+dpBmmzOMeTgp8Op3+dAlsufMlMYlIs8iS9
         upF0mTnmvajjojM8MPdkoGtfhUhBxPYTZjMb/zpGYbhUy3QYKQ1CK5meqIT5gEsJA9ZE
         CRLrRSO/8geI1quqIMToN4A2ReLUMFCQ3tjESpRvvmUomDnVY6qNtiSLypF5+4KYu+cm
         4sLw1IHV9b2KJCVufcTHxiA1g+xgPTC65ICSfpQwIT588efN5HXvv5bEdfs4ABywVBUN
         fIZulbB6cCKs2IhXkwuZNZ0wyULJ9TQLiixtNKAUAB+yjf5IoF9Ry7q5h3Ra4yVJVcvd
         VJFQ==
X-Gm-Message-State: AOAM533ty8WDwoSdifQq6Oaq2R9+dWKWwOrvyDsGQ295RHcUSMEvjeB5
        4FHvVlpkVoVW4KWjFEy/TUo=
X-Google-Smtp-Source: ABdhPJzgIwtUHqywWSb++SyR+Glcrg7g6wJrKniv/gACQingXXGZbpl4p6QI9ypQQOupz458IXN+QA==
X-Received: by 2002:adf:9b8a:: with SMTP id d10mr1160468wrc.151.1634153633361;
        Wed, 13 Oct 2021 12:33:53 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id h1sm304088wmb.7.2021.10.13.12.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:33:52 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Wed, 13 Oct 2021 21:33:52 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Stephen <stephenackerman16@gmail.com>, djwong@kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, rppt@kernel.org,
        James.Bottomley@hansenpartnership.com, akpm@linux-foundation.org,
        david@redhat.com, hagen@jauu.net
Subject: Re: kvm crash in 5.14.1?
Message-ID: <YWc0oInpEu6kxmOv@eldamar.lan>
References: <85e40141-3c17-1dff-1ed0-b016c5d778b6@gmail.com>
 <2cd8af17-8631-44b5-8580-371527beeb38@gmail.com>
 <YWcs3XRLdrvyRz31@eldamar.lan>
 <f430d53f-59cf-a658-a207-1f04adb32c56@redhat.com>
 <YWczkHnrv5ZQAkCH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWczkHnrv5ZQAkCH@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, Oct 13, 2021 at 07:29:20PM +0000, Sean Christopherson wrote:
> On Wed, Oct 13, 2021, Paolo Bonzini wrote:
> > On 13/10/21 21:00, Salvatore Bonaccorso wrote:
> > > Hi,
> > > 
> > > On Sat, Oct 09, 2021 at 12:00:39PM -0700, Stephen wrote:
> > > > > I'll try to report back if I see a crash; or in roughly a week if the
> > > > system seems to have stabilized.
> > > > 
> > > > Just wanted to provide a follow-up here and say that I've run on both
> > > > v5.14.8 and v5.14.9 with this patch and everything seems to be good; no
> > > > further crashes or problems.
> > > 
> > > In Debian we got a report as well related to this issue (cf.
> > > https://bugs.debian.org/996175). Do you know did the patch felt
> > > through the cracks?
> > 
> > Yeah, it's not a KVM patch so the mm maintainers didn't see it.  I'll handle
> > it tomorrow.
> 
> It's queued in the -mm tree.
> 
> https://lore.kernel.org/mm-commits/20211010224759.Ny1hd1WiD%25akpm@linux-foundation.org/

Sean and Paolo, thank you, missed the above.

Regards,
Salvatore
