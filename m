Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0BC5F7DF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 21:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJGTZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 15:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiJGTZb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:25:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23268A1D2
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Oct 2022 12:25:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f140so5758453pfa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Oct 2022 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YEbfybP388TCQjNqPlb82aEm4N4f2G4wSjk08TCY7/w=;
        b=SOtLwSz9tXcXxTmwbbgmMPqSTh3MUoFR/dzcDjDu/6l2PG68hhAus18YGQB6ZtTPtx
         4PSissb5mv1lSFuNfZNNvYmhk/+o3dvDAPpRoRsr9uQVQNaqBcbk6VgpTqhL+npf/dVQ
         L2bm/59zYoEW61TOuC1x7VK5foWHbIK4RgS6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEbfybP388TCQjNqPlb82aEm4N4f2G4wSjk08TCY7/w=;
        b=kmd0xD+cPG3TWpRi2JNtt6bPV1h02w2yvwH8q0MKB1Yj1bTA5GAixMsR8ch/PiIRsx
         ONTM5+fnIAwqCS1GT4HLJHV5Ojn0eAfHNAf3KDdLYHt5KcaFHH3T5qWGH0omriY0P7hY
         Utqp07gr5+VfvsxH7kE82ia0Ron0oVN4eXjI6vbOqhdjLsIFTcbtqJ35025AoPwQ8PaS
         fEigcmI51NFQhc6YUuholHFdEEcaw/q2XOpdfTtZTN2i7vFhK1L2zWuUR4346Y0TWORe
         dXeUOk6+ZQGmx7qFs4lG4Kzmd6CI2xx+o6ODX+DOcrcxWtxw8HUju4Kbq8kmF8aHSZmJ
         rJrw==
X-Gm-Message-State: ACrzQf1nkKGSF4GrDhqp0xX3NNa3LwtSbss/celn2KW30X7wyg/rPuSi
        ikrfW/aLW0C5wWfHx9fc49EbFQ==
X-Google-Smtp-Source: AMsMyM6oVNbIx3oWZxYtzOismBsc5yRtY9+oLVPNFrY1MbuEOuXqJ+ghahWioBa3bPmtF4s5W01PsA==
X-Received: by 2002:a63:35c6:0:b0:44c:e23b:8c80 with SMTP id c189-20020a6335c6000000b0044ce23b8c80mr5744016pga.69.1665170729364;
        Fri, 07 Oct 2022 12:25:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n1-20020aa79841000000b005289a50e4c2sm2029061pfq.23.2022.10.07.12.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 12:25:28 -0700 (PDT)
Date:   Fri, 7 Oct 2022 12:25:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net
Subject: Re: [PATCH 6/8] MAINTAINERS: Add a mailing-list for the pstore
 infrastructure
Message-ID: <202210071224.A313239@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-7-gpiccoli@igalia.com>
 <202210061616.9C5054674A@keescook>
 <8e3b9e43-2dcf-76b1-b9bc-d66cb1e059cd@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e3b9e43-2dcf-76b1-b9bc-d66cb1e059cd@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 07, 2022 at 01:32:57PM -0300, Guilherme G. Piccoli wrote:
> On 06/10/2022 20:22, Kees Cook wrote:
> > On Thu, Oct 06, 2022 at 07:42:10PM -0300, Guilherme G. Piccoli wrote:
> >> Currently, this entry contains only the maintainers name. Add hereby
> > 
> > This likely need a general refresh, too.
> > 
> > Colin, you haven't sent anything pstore related since 2016. Please let
> > me know if you'd like to stay listed here.
> > 
> > Anton, same question for you (last I see is 2015).
> > 
> > Tony, I see your recent responses, but if you'd rather not be bothered
> > by pstore stuff any more, please let me know. :)
> > 
> 
> Hi Kees, in case you want an extra pair of eyes to review/test pstore,
> you can add me as reviewer - since we're using pstore in the Steam Deck
> now and I have some improvements/fixes planned, I could help testing and
> reviewing the stuff as well.

Sure! That'd be lovely. :)

-- 
Kees Cook
