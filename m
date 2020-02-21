Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5886D167D81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 13:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgBUMah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 07:30:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42337 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgBUMah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 07:30:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id w21so900471pgl.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 04:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uyerPeK9P8LqDlV7LqFL68c1sT2T1cP6gBnBuIAjadc=;
        b=DH263imKuVYHuV7EPkqh1eCSelnzcxPWxEzuOsU3MCY3TYDfuO7Nw2xSXuTBxCvKqU
         PV4ReVe9Ez5GMFdMKV60cvkjNGSA30SJhBQERM6jcTGT7YyFOTx55Sn8jBN5jauV0mbO
         PVlFmsHTaxcwByzlq653WpLCkV6XCuXOVqfmtnE899xmEZT8yck8t9Bg6na0TVR9qa6I
         1q/y8RyuYd8LoGbJozNSNdjIWRYNapZrDW4+y8WoB6OJMeEL/DFJe4jSdjbGRZFDRsCo
         NcLn+fhFFUU6iGm8zPJuscczpWxP7kC11r/MBHqAXx986E1VN/5ag6lTlXC2tdBcnOTO
         Dg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uyerPeK9P8LqDlV7LqFL68c1sT2T1cP6gBnBuIAjadc=;
        b=CJXL7jFAe9aDoasnvQgRhPvJN9G/OdshaUr+cM0S5hlrrso1JmUlpnnODjLyN4LdpR
         cMyUBDw5ttw/thFGYfryYnbJoatqiw5drwpGP0y0UYg8y9B7CRspe+jTFBl7RyMHzkjA
         zeIrdc81InUY3m/hMzZ9mPVQuamp/vDgec4FzdqDqDgnsKVs1xpooorJigBARAK/Dtjl
         E/D4WJOTPpvOwJr8oqUqZwURIfvQ36Bugnvt36EgSfc3maR0V2Pw+bS3XQxGaw+5VCsQ
         giyhQXcsHQmkcMEMPmqwEYKAQDub2Xt17LoJI66wwSqOUip55kN4yJFx8iJEBT2RsB0j
         9W8A==
X-Gm-Message-State: APjAAAUVHIjl/shtNlDJXvFG2IOCHenF4YAecMAg+lBr1L9mouCBysFN
        7Gb1CZTQYzVs5ortPIof7ijiWA==
X-Google-Smtp-Source: APXvYqy4UbSXqOZGpOmD7o9lFGwKmBa5kKvuV+uXccjEFuj1rsjXLaJzspJLLddDZl/DDXo6gKy6HQ==
X-Received: by 2002:aa7:979a:: with SMTP id o26mr37568002pfp.257.1582288236069;
        Fri, 21 Feb 2020 04:30:36 -0800 (PST)
Received: from google.com ([2620:15c:201:0:7f8c:9d6e:20b8:e324])
        by smtp.gmail.com with ESMTPSA id r12sm723387pgu.93.2020.02.21.04.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 04:30:35 -0800 (PST)
Date:   Fri, 21 Feb 2020 04:30:30 -0800
From:   Satya Tangirala <satyat@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 0/9] Inline Encryption Support
Message-ID: <20200221123030.GA253045@google.com>
References: <20200108140556.GB2896@infradead.org>
 <20200108184305.GA173657@google.com>
 <20200117085210.GA5473@infradead.org>
 <20200201005341.GA134917@google.com>
 <20200203091558.GA28527@infradead.org>
 <20200204033915.GA122248@google.com>
 <20200204145832.GA28393@infradead.org>
 <20200204212110.GA122850@gmail.com>
 <20200205073601.GA191054@sol.localdomain>
 <20200205180541.GA32041@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205180541.GA32041@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

I sent out v7 of the patch series. It's at
https://lore.kernel.org/linux-fscrypt/20200221115050.238976-1-satyat@google.com/T/#t

It manages keyslots on a per-request basis now - I made it get keyslots
in blk_mq_get_request, because that way I wouldn't have to worry about
programming keys in an atomic context. What do you think of the new
approach?

On Wed, Feb 05, 2020 at 10:05:41AM -0800, Christoph Hellwig wrote:
> On Tue, Feb 04, 2020 at 11:36:01PM -0800, Eric Biggers wrote:
> > The vendor-specific SMC calls do seem to work in atomic context, at least on
> > SDA845.  However, in ufshcd_program_key(), the calls to pm_runtime_get_sync()
> > and ufshcd_hold() can also sleep.
> > 
> > I think we can move the pm_runtime_get_sync() to ufshcd_crypto_keyslot_evict(),
> > since the block layer already ensures the device is not runtime-suspended while
> > requests are being processed (see blk_queue_enter()).  I.e., keyslots can be
> > evicted independently of any bio, but that's not the case for programming them.
> 
> Yes.
> 
> > That still leaves ufshcd_hold(), which is still needed to ungate the UFS clocks.
> > It does accept an 'async' argument, which is used by ufshcd_queuecommand() to
> > schedule work to ungate the clocks and return SCSI_MLQUEUE_HOST_BUSY.
> > 
> > So in blk_mq_dispatch_rq_list(), we could potentially try to acquire the
> > keyslot, and if it can't be done because either none are available or because
> > something else needs to be waited for, we can put the request back on the
> > dispatch list -- similar to how failure to get a driver tag is handled.
> 
> Yes, that is what I had in mind.
> 
> > However, if I understand correctly, that would mean that all requests to the
> > same hardware queue would be blocked whenever someone is waiting for a keyslot
> > -- even unencrypted requests and requests for unrelated keyslots.
> 
> At least for an initial dumb implementation, yes.  But if we care enough
> we can improve the code to check for the encrypted flag and only put
> back encrypted flags in that case.
> 
> > It's possible that would still be fine for the Android use case, as vendors tend
> > to add enough keyslots to work with Android, provided that they choose the
> > fscrypt format that uses one key per encryption policy rather than one key per
> > file.  I.e., it might be the case that no one waits for keyslots in practice
> > anyway.  But, it seems it would be undesirable for a general Linux kernel
> > framework, which could potentially be used with per-file keys or with hardware
> > that only has a *very* small number of keyslots.
> > 
> > Another option would be to allocate the keyslot in blk_mq_get_request(), where
> > sleeping is still allowed, but some merging was already done.
> 
> That is another good idea.  In blk_mq_get_request we acquire other
> resources like the tag, so this would be a very logical places to
> acquire the key slots.  We can should also be able to still merge into
> the request while it is waiting.
