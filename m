Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B2C520B21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 04:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiEJC1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 22:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiEJC13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 22:27:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBEA17EC33;
        Mon,  9 May 2022 19:23:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i17so15525523pla.10;
        Mon, 09 May 2022 19:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=6/agFKZVEdVDsrXQEEfaXW6kYgW1c8TH8P87O2R+AuI=;
        b=mG9g2mMstF8Cm/8Ole2BQDDCAn/yBDrtFtfPrKm4u+9rkbufL9pK5fRbsf6eBYZzI3
         +kbCSyTF7wPsoB4WwC1H8/dXvNdUoHMBisTI1lOXAn/cFp3WlaaC7pj+f4EswXey+rdi
         8/MKrRaMLc5TmRnWvqT3Bm/nwaIUrY6FuL60MYSsLycLVXSRwBI9wWoz7pE3Z4o9UrXR
         UylW7JhbxB7Bhko8uwYEfdhuejwrbAeKMtOOt0xSXWUmECbFcejZp+Q0+WRUQOFNElYf
         CrL+pGY7FaE2ctaNDcqEWicnzByj1PpKlhN/YAjrStFDAOtywnDpD2x06mzAYO+MhWrH
         n7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=6/agFKZVEdVDsrXQEEfaXW6kYgW1c8TH8P87O2R+AuI=;
        b=R0gG3tR0CcQk9a7uCku7nE0YIckDO/UjpUCzZUB5cD4IIXVql3udL277kV4Pg8LXn2
         pyIuxImM2vQvV0M9f2L4ODmsPyKMfBD50oMdufv6MQ+lXcazSlDbyHYI1RO7XBgEXeQc
         F7Bh9siTClTKEMZIxkAo/+jN9V90TcyLGw37liTvIa12OPFQMes3cXigvTQO8NXiE/cM
         oaMgCcPLBSvJCCocpBimOnHtmqCbtUHqIgHFWjUwuMa18A32eZmmS2ItV8fhLoD4FAki
         1H5fe3Noz/CQZbEnK7vkszLtBZCMWPbpd9PcAHSXAeGm9HnCGM470b6qqHFjES5gWcMW
         PcRA==
X-Gm-Message-State: AOAM531UIPJ62BNZ9kDIvgrzvhTfPNbewv28N3oIqoIFt3bUnRHwZYNB
        6xvnESl2h4LeexKva/GUmuY=
X-Google-Smtp-Source: ABdhPJzYcvj9/KVB+ZVKxAPPK6e99ItRz2VlkXR1gDQExEfNPTMYalzk9Np8fZOiwVxmDZEAbNWoug==
X-Received: by 2002:a17:90b:3d0:b0:1d9:52e1:de86 with SMTP id go16-20020a17090b03d000b001d952e1de86mr28829581pjb.73.1652149412660;
        Mon, 09 May 2022 19:23:32 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p67-20020a622946000000b0050dc7628150sm9305952pfp.42.2022.05.09.19.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 19:23:31 -0700 (PDT)
Message-ID: <6279cca3.1c69fb81.c4e50.581d@mx.google.com>
X-Google-Original-Message-ID: <20220510022329.GA1278331@cgel.zte@gmail.com>
Date:   Tue, 10 May 2022 02:23:29 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn,
        zhang.yunkai@zte.com.cn
Subject: Re: [PATCH v5] mm/ksm: introduce ksm_force for each process
References: <20220507105926.d4423601230f698b0f5228d1@linux-foundation.org>
 <20220508092710.930126-1-xu.xin16@zte.com.cn>
 <YngF+Lz01noCKRFc@casper.infradead.org>
 <6278bb5f.1c69fb81.e623f.215f@mx.google.com>
 <Ynk2AsCEl1fk/WaS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynk2AsCEl1fk/WaS@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 04:40:50PM +0100, Matthew Wilcox wrote:
> On Mon, May 09, 2022 at 06:57:33AM +0000, CGEL wrote:
> > On Sun, May 08, 2022 at 07:03:36PM +0100, Matthew Wilcox wrote:
> > > On Sun, May 08, 2022 at 09:27:10AM +0000, cgel.zte@gmail.com wrote:
> > > > If ksm_force is set to 0, cancel the feature of ksm_force of this
> > > > process and unmerge those merged pages belonging to VMAs which is not
> > > > madvised as MADV_MERGEABLE of this process, but leave MADV_MERGEABLE
> > > > areas merged.
> > > 
> > > Is that actually a useful feature?  Otherwise, we could simply turn
> > > on/off the existing MMF_VM_MERGEABLE flag instead of introducing this
> > > new bool.
> > > 
> > I think this will be very useful for those apps which are very likely to
> > cause Same Pages in memory and users and operators are not willing to
> > modified the source codes for any reasons.
> 
> No, you misunderstand.  Is it useful to have the "force KSM off"
> functionality?  ie code which has been modified to allow KSM, but
> then overridden by an admin?
> 
Oh, I see what you mean. It should be mentioned that "force KSM off" is not
implemented for the current patch. In this patch, setting ksm_force to 0 just
restores the system to the default state (the state before patching)

> > Besides, simply turning of/off the existing MMF_VM_MERGEABLE flag may be
> > not feasible because madvise will also turn on the MMF_VM_MERGEABLE
> > flag.
> > 
> > I think the following suggestions is good, and I will resend a patch.
> > > > +Controlling KSM with procfs
> > > > +===========================
> > > > +
> > > > +KSM can also operate on anonymous areas of address space of those processes's
> > > > +knob ``/proc/<pid>/ksm_force`` is on, even if app codes doesn't call madvise()
> > > > +explicitly to advise specific areas as MADV_MERGEABLE.
> > > > +
> > > > +You can set ksm_force to 1 to force all anonymous and qualified VMAs of
> > > > +this process to be involved in KSM scanning. But It is effective only when the
> > > > +klob of ``/sys/kernel/mm/ksm/run`` is set as 1.
> > > 
> > > I think that last sentence doesn't really add any value.
> > > 
> > > > +	memset(buffer, 0, sizeof(buffer));
> > > > +	if (count > sizeof(buffer) - 1)
> > > > +		count = sizeof(buffer) - 1;
> > > > +	if (copy_from_user(buffer, buf, count)) {
> > > > +		err = -EFAULT;
> > > > +		goto out_return;
> > > 
> > > This feels a bit unnecessary.  Just 'return -EFAULT' here.
> > > 
> > > > +	}
> > > > +
> > > > +	err = kstrtoint(strstrip(buffer), 0, &force);
> > > > +
> > > > +	if (err)
> > > > +		goto out_return;
> > > 
> > > 'return err'
> > > 
> > > > +	if (force != 0 && force != 1) {
> > > > +		err = -EINVAL;
> > > > +		goto out_return;
> > > 
> > > 'return -EINVAL'
> > > 
> > > > +	}
> > > > +
> > > > +	task = get_proc_task(file_inode(file));
> > > > +	if (!task) {
> > > > +		err = -ESRCH;
> > > > +		goto out_return;
> > > 
> > > 'return -ESRCH'
