Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B3658DB45
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244692AbiHIPi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 11:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244615AbiHIPiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:38:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24111CB20
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 08:38:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j15so14770088wrr.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Aug 2022 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=VPZpeIaD9GCj1+EcsItqLp19LBrb3woyTCT9WSQsJ0w=;
        b=bzhWg+clYNYRnSV0BR3ohJ3k2WXRsbp71AIXs7BOKVyaCfLx5YDYxRt5/iy0y80Lb5
         zZv1L4BPVP17RCIkXkU0dWbOhyRVLnBdkse/3me465IHLKKjW1u0kCOX4AmM4Q0ARAI3
         5mmyEQijYOVMb/XSZYig6E7YdtSH9bCQDDhrPGpYlPb88sLzqtPY+lefX86FEC2G2+O1
         aKsHjTd203a6di2GdQ1qe7Go2LZhUveIDhMQHyce5xVi7xR40HvS8UHlAhXp1xQefard
         LX9hSa+/brmeIZT57jCY6WVuZ7xS8W9ScF4TMycEpuyXyy+f2YlBALWVZ72ZLED3TZuR
         x/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=VPZpeIaD9GCj1+EcsItqLp19LBrb3woyTCT9WSQsJ0w=;
        b=SflheKBNH4eFfPBJGEfFN5VIPI0Py0OtUqYBAiv+v0w0NF/lBs0pX3o+SEYEBYIKnE
         k9kJ7rNlLDM7ZsRPFFqOOL267TVj0rxXX4M8WLTKlnkHKzYwkVQW5x4PJjbe36pbz1Ei
         Nl8Ou63l3ON/LbUKqpb1XQsGpmC5dlEIlVqnJXWaF2ZTQB8LxHYxldn8NTBU9duL4xAo
         Za0MxTa3aCjqD56bD1+CQa9fG+5udDfwy4zjGkVDsRf4gMK2vAy6RtbEXW9B/1UoL2Wt
         biI/VdzTj1UdbNS7MgfnEA/9QB40emkYdY9Qec/r787YkZsEJt9m1GAw6884ViufUNEu
         R4mA==
X-Gm-Message-State: ACgBeo2oQEhS9QJ+skzo/H8cBxttpmPWa3e8U2fPZNC/0SAraEWeFPwi
        aCaI+Jviovagh/P1ivruXhunew==
X-Google-Smtp-Source: AA6agR5rJJQy6elpnvBdtFmt1M5yi5AmqAc9hCSd6ZetaToUgv+oPGHryWxVeYa8LI3Q1TqACYVbgg==
X-Received: by 2002:a5d:64ca:0:b0:220:6247:42c1 with SMTP id f10-20020a5d64ca000000b00220624742c1mr14674640wri.478.1660059490136;
        Tue, 09 Aug 2022 08:38:10 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c414a00b003a32167b8d4sm23056165wmm.13.2022.08.09.08.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 08:38:09 -0700 (PDT)
Date:   Tue, 9 Aug 2022 16:38:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Haimin Zhang <tcs.kernel@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2] fs/pipe: Deinitialize the watch_queue when pipe is
 freed
Message-ID: <YvJ/XzuyWbZT2dlO@google.com>
References: <20220509131726.59664-1-tcs.kernel@gmail.com>
 <Ynl+kUGRYaovLc8q@sol.localdomain>
 <YsVYQAQ8ylvMQtR2@google.com>
 <Yta5+UOcK2rgBT6q@google.com>
 <YumdcdmPxqmx3AQc@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YumdcdmPxqmx3AQc@sol.localdomain>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 02 Aug 2022, Eric Biggers wrote:

> On Tue, Jul 19, 2022 at 03:04:41PM +0100, Lee Jones wrote:
> > On Wed, 06 Jul 2022, Lee Jones wrote:
> > 
> > > On Mon, 09 May 2022, Eric Biggers wrote:
> > > 
> > > > On Mon, May 09, 2022 at 09:17:26PM +0800, Haimin Zhang wrote:
> > > > > From: Haimin Zhang <tcs_kernel@tencent.com>
> > > > > 
> > > > > Add a new function call to deinitialize the watch_queue of a freed pipe.
> > > > > When a pipe node is freed, it doesn't make pipe->watch_queue->pipe null.
> > > > > Later when function post_one_notification is called, it will use this
> > > > > field, but it has been freed and watch_queue->pipe is a dangling pointer.
> > > > > It makes a uaf issue.
> > > > > Check wqueu->defunct before pipe check since pipe becomes invalid once all
> > > > > watch queues were cleared.
> > > > > 
> > > > > Reported-by: TCS Robot <tcs_robot@tencent.com>
> > > > > Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> > > > 
> > > > Is this fixing something?  If so it should have a "Fixes" tag.
> > > 
> > > It sure is.
> > > 
> > > Haimin, are you planning a v3?
> > 
> > This patch is set to fix a pretty public / important bug.
> > 
> > Has there been any more activity that I may have missed?
> > 
> > Perhaps it's been superseded?
> 
> I think this was already fixed (correctly, unlike the above patch which is very
> broken) by the following commit:
> 
> 	commit 353f7988dd8413c47718f7ca79c030b6fb62cfe5
> 	Author: Linus Torvalds <torvalds@linux-foundation.org>
> 	Date:   Tue Jul 19 11:09:01 2022 -0700
> 
> 	    watchqueue: make sure to serialize 'wqueue->defunct' properly

Thanks Eric, I'll back-port this one instead.

-- 
DEPRECATED: Please use lee@kernel.org
