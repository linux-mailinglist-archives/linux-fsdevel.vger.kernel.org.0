Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1AB59C94F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 21:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiHVTy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 15:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiHVTyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:54:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39864402FD
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 12:54:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a16so8467130lfs.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=mJYkjoFM1MNYDjxafvXKEPUbvJhzVrTSHnNsQsuncUA=;
        b=AsCF/DmtHu2Jmnl9CHMjfwMS+IXEr7nmauJCOI8GcgiO7HgXBdj+UWyVv11d5fVSs6
         LDPpik1XpQcnxNI5k/evDP8Kb9U3Te5Qjplyi8TAS2F4H57aZRz/3oKx7Iv8ezdzImyZ
         oytbi1mUJ76xXIBiWcTM7EmbGckM8K5mj5+F9BtK7sqrWZ4z/eM1Wg4l/V9iuDSAaqRN
         FDi4uJ0rOrQrVshXWq5YExAMlKOk13pNorYc0qn78gM8cJwx8WBnEvIpeaZ4IUIxBdY7
         inaJsAZ9fhFf7bWULI/1R2cWSS5wxOwgb5w51gD9Dh5NvrD78ZjQ0Z8tumtMVoiGf5/3
         PetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=mJYkjoFM1MNYDjxafvXKEPUbvJhzVrTSHnNsQsuncUA=;
        b=6cVCwm8jTxzDwYL7yeOncXpiVynJTiDf3iFOcpsT5HCburAYH58j+16j2yOOQosBKP
         o+IXGqUs3ZXA3qNoC39YfSilAowgRF7u5hQBcn/oBlHcKiV3B6pueKp+AG0qAlhdkXkw
         UgRNZfCq+nnQB4a30O4bwFnqFivRsk8QoJn3ueY4XEuN6PCSolGZ35f96KWqHn+8OBNt
         ahDpvsqpsx8gvCasVpr4opHgfP0PJdPSJgrjwtX3qUrLUwRvYI8ERCBrezpIXY/PgHyn
         /hnPAyXK1FnnpOnY2tRuPGjGF7KTpMLIPklmW5v8X07MRYORqz7i0Fos7ea2RQIkNSCR
         5Nvw==
X-Gm-Message-State: ACgBeo3qQ189JVLmS5aIMRfqf9NnamKQBxttiiLVqTUXv0boa2+uvvdu
        DbIT7wUaYPxRSnJAoa02BEk=
X-Google-Smtp-Source: AA6agR4gMsy8l1NhQm/H2kJ/k9mi/lPb1q9eNX5xzbOH/YfWEJirzsqfcrr4tJ2FzPRiVne+Rm4agw==
X-Received: by 2002:a05:6512:acd:b0:492:b8e0:2ef4 with SMTP id n13-20020a0565120acd00b00492b8e02ef4mr6981068lfu.360.1661198062396;
        Mon, 22 Aug 2022 12:54:22 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id p5-20020a05651238c500b0048a83336343sm2075680lft.252.2022.08.22.12.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:54:21 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 22 Aug 2022 21:54:17 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] vmap_folio()
Message-ID: <YwPe6TOJWu3q2VYe@pc636>
References: <YvvdFrtiW33UOkGr@casper.infradead.org>
 <Yv6qtlSGsHpg02cT@casper.infradead.org>
 <Yv9rrDY2qukhvzs5@pc636>
 <Yv+wAS9JXbYvufaW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv+wAS9JXbYvufaW@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 19, 2022 at 04:45:05PM +0100, Matthew Wilcox wrote:
> On Fri, Aug 19, 2022 at 12:53:32PM +0200, Uladzislau Rezki wrote:
> > Looks pretty straightforward. One thing though, if we can combine it
> > together with vmap(), since it is a copy paste in some sense, say to
> > have something __vmap() to reuse it in the vmap_folio() and vmap().
> > 
> > But that is just a thought.
> 
> Thanks for looking it over!
> 
You are welcome.

>
> Combining it with vmap() or vm_map_ram() is tricky.  Today, we assume
> that each struct page pointer refers to exactly PAGE_SIZE bytes, so if
> somebody calls alloc_pages(GFP_COMPOUND, 4) and then passes the head
> page to vmap(), only that one page gets mapped.  I don't know whether
> any current callers depend on that behaviour.
> 
> Now that I look at the future customers of this, I think I erred in basing
> this on vmap(), it looks like vm_map_ram() is preferred.  So I'll redo
> based on vm_map_ram().
> 
Indeed, the vmap code has no knowledge about comound pages. You can add
me to CC, so i can have a look on it to help out with it if there will
be a need.

--
Uladzislau Rezki
