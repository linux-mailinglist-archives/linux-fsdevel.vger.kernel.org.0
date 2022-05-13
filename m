Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5D6525BC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377455AbiEMGug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 02:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359479AbiEMGue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 02:50:34 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BF72A28F3;
        Thu, 12 May 2022 23:50:33 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v10so6657184pgl.11;
        Thu, 12 May 2022 23:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=2DjFMlbToeflubltope1cW16jNjoqvae24DnuKigYd0=;
        b=YLQ8p5V8Jm/yaYvz89gZcEQbFnfOV+fH5sllWVlFo2/7bV7Uw+tJ32cgWTKApk6GCr
         jp+7Ke9Hvsfq0VfBrIPfAZAXnlGadmw4mdqH3OxQdwg56ZZM4p1uujlSopnxxYS1iTtk
         AcO+DojoDMXKPy/RRzUKVpavC0TEr8IDZ2uxMs0nJCTqw4bQGz76ORe8jvrjuBmkCUoq
         YhEdEta0A5aoIou6AgwwM7oaPCBW1et1b/hM/X/dFP6VSDp/vlG4+aUJZjqlS+TDMqD+
         NU7bRUM1ka4CkWESMedU6k55jpibywDsdAf9cTjd4DEKvbaAvsxBgGu9AE1UmBhFbywC
         LrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=2DjFMlbToeflubltope1cW16jNjoqvae24DnuKigYd0=;
        b=Hwo5qi6bEhZZT2OfjxJHhJY7mCCc7/Twu6UmhoBO8BHcwT2iH6B/9/CFxwHwvM9KLv
         bWT8fFE6HTAOlx0yP/ptLvpVA+ByGjJ9nRCWVf5Pme2hFNZGKzvSbwJQi+URBel01ip8
         r5pMJ5HiWRSII35QbELYJVm9yhMGvCoWztJU2L2xXZ4gxZWo/NcIgyjay5yS13xeA8Zn
         xBiJeDNZugdJ/ebODQhCNB2HVdSExU+YApZyIf1NfU+AZJ5JhZ2x3WTK/jKtOTYHEWxV
         d+W3afq4dgG0isKKAQ0LsbAGeqHpij2UWtQqGmw5gP3VoiURuvEo/exzxXgfirHlBIDy
         J20w==
X-Gm-Message-State: AOAM531xhdiBuPVKLA3HNz4sjtGPJFa67IBYGTiGkz2q/pBkfsKb9w07
        VesjmlH8Qi86Kmf9+KCLx8vUzQMYR+A=
X-Google-Smtp-Source: ABdhPJw+Ue6PHI9R3DkYOivzBxcg0Vl9q6yqPk4Ofjbw0ON0I2wwY2YlNzehWR/GOBWHfA9hepSuFA==
X-Received: by 2002:a63:6bc6:0:b0:3c6:b38b:a84 with SMTP id g189-20020a636bc6000000b003c6b38b0a84mr2813151pgc.422.1652424633367;
        Thu, 12 May 2022 23:50:33 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b10-20020a621b0a000000b0050dc76281fasm929772pfb.212.2022.05.12.23.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 23:50:32 -0700 (PDT)
Message-ID: <627dffb8.1c69fb81.2daf.2c76@mx.google.com>
X-Google-Original-Message-ID: <20220513065031.GA1630548@cgel.zte@gmail.com>
Date:   Fri, 13 May 2022 06:50:31 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, corbet@lwn.net,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH v6] mm/ksm: introduce ksm_force for each process
References: <20220510122242.1380536-1-xu.xin16@zte.com.cn>
 <Yn12/ZMyQEnSh0Ge@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn12/ZMyQEnSh0Ge@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 10:07:09PM +0100, Matthew Wilcox wrote:
> On Tue, May 10, 2022 at 12:22:42PM +0000, cgel.zte@gmail.com wrote:
> > +++ b/Documentation/admin-guide/mm/ksm.rst
> > @@ -32,7 +32,7 @@ are swapped back in: ksmd must rediscover their identity and merge again).
> >  Controlling KSM with madvise
> >  ============================
> >  
> > -KSM only operates on those areas of address space which an application
> > +KSM can operates on those areas of address space which an application
> 
> "can operate on"
>
Thanks.

> > +			 * Force anonymous pages of this mm to be involved in KSM merging
> > +			 * without explicitly calling madvise.
> > +			 */
> > +			if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
> > +				err = __ksm_enter(mm);
> > +			if (!err)
> > +				mm->ksm_force = force;
> > +		}
> > +
> > +		mmap_write_unlock(mm);
> > +	}
> 
> There's a much simpler patch hiding inside this complicated one.
> 
> 	if (force) {
> 		set_bit(MMF_VM_MERGEABLE, &mm->flags));
> 		for each VMA
> 			set VM_MERGEABLE;
> 		err = __ksm_enter(mm);
> 	} else {
> 		clear_bit(MMF_VM_MERGEABLE, &mm->flags));
> 		for each VMA
> 			clear VM_MERGEABLE;
> 	}
> 
> ... and all the extra complications you added go away.

Sorry, but I don't think that is a better way of implementation, although it
is simpler. It overrides the intention of code ifself which is
unrecoverable. For example, if a program which madvise just a part of VMAs
(not all) as MERGEABLE then its ksm_force is turned on, and subsequently
it ksm_force is turned off again, the "madvised MERGEBLE" cannot be
recoverd.
===========================================================================
I have a idea: can we refer to the interface of THP? Substitute ksm_force
with ksm_enabled and give three values to it:

1) always: force all anonymous VMAs of this process to be scanned.

2) madvise: the default state, unless user code call madvise, don't
scan this process.

3) never: never be involed in KSM.
===========================================================================

How about this?
