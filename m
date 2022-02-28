Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCC14C7AAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 21:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiB1Umb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 15:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiB1Um3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:42:29 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3688A20F50
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 12:41:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cp23-20020a17090afb9700b001bbfe0fbe94so255344pjb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 12:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wer/Oz2nOAI419q72n4sbW/GCj0W5Nx8xz2+Rlt0xdI=;
        b=EPfWBDQTZQfFwTLJ9+iWGHrZjstF+IJdDCO2XmrpedQZl8eoQHqJA+/JViu23cwxXh
         4cMj/vzH9luSjFoMSUEnTyFggS72ppUy5QkoOhB1ZLmlYGZVjojhreHYu2ecNsLh0VEG
         gCNAXqAhIEMo9kYwHuvCozq3SDVVbHt3LuY2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wer/Oz2nOAI419q72n4sbW/GCj0W5Nx8xz2+Rlt0xdI=;
        b=Rnci0PTuewjtnL0W06v0Rl1OQPE6ZSh2MIRZTeoycGaqWOhtj8r/btgOY3wHrJnrn9
         Z3b+49VPe2LUxTiPpxFp4Vgw+rXsoW2WahSCeZ5zpRW+oZQBJM7iSFkVdQBfbZPlrSfa
         eTmVE6tZTFsrgwi4KrUt+RDtRv/OHfLoNZtSFCwUUVdOeUPOwK66GuPmwsmDPULxNW8A
         udhjR3cR2e6OygOmigtrj3bHwaZze4hMQCmTvme+Dc0dLyQNDjfkrxgs5sOJsfWuf5E9
         82HiIoCKVfWg4qcRrcGc5UOGvrrASYmw5c4HOgbMPqgO2G2b5045bZ1C34o19QdBZgbJ
         YlCA==
X-Gm-Message-State: AOAM530HksF1/DnU03nigf6rio/UWn2Ov0DNV8BmBnqMU/vztAu0CjAA
        dzR4L1XiTc0aIM1O9OaM3NdAXQ==
X-Google-Smtp-Source: ABdhPJy3Ync6bess6WVePu+xmx/XAAZ+UJXR4GrnPlEoCAlv3kx6LFgNA1dRDLp+plPQLZbHhc+glA==
X-Received: by 2002:a17:903:2482:b0:150:15ed:3cd3 with SMTP id p2-20020a170903248200b0015015ed3cd3mr21772341plw.147.1646080908566;
        Mon, 28 Feb 2022 12:41:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t38-20020a056a0013a600b004e1a0c14000sm15037898pfg.209.2022.02.28.12.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 12:41:48 -0800 (PST)
Date:   Mon, 28 Feb 2022 12:41:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Magnus =?iso-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>
Cc:     akpm@linux-foundation.org, anthony.yznaga@oracle.com,
        glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        matoro_bugzilla_kernel@matoro.tk,
        matoro_mailinglist_kernel@matoro.tk, regressions@leemhuis.info,
        regressions@lists.linux.dev, viro@zeniv.linux.org.uk
Subject: Re: regression: Bug 215601 - gcc segv at startup on ia64
Message-ID: <202202281240.8BCFBB47ED@keescook>
References: <202202260344.63C15C3356@keescook>
 <Yhyn9cjDV8XfXLHm@fractal.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yhyn9cjDV8XfXLHm@fractal.localdomain>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 11:46:13AM +0100, Magnus Groß wrote:
> > When the kernel tries to map these with a combined allocation, it asks
> > for a giant mmap of the file, but the file is, of course, not at all
> > that large, and the mapping is rejected.
> 
> > So... I'm trying to think about how best to deal with this. If I or
> > anyone else can't think of an elegant solution, I'll send a revert for
> > the offending patch next week.
> 
> Shouldn't we just be able to patch total_mapping_size() again to instead
> sum up all p_memsz fields, instead of comparing minimum and maximum
> p_vaddr?

I don't think so, and I need to have a "minimal change" to fix this so
it's more obviously correct.

And, apologies, I failed to Cc you on this patch:
https://lore.kernel.org/linux-hardening/20220228194613.1149432-1-keescook@chromium.org/

-- 
Kees Cook
