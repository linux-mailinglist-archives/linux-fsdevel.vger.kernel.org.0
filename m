Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49BA58DF43
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 20:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbiHISnO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 14:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344362AbiHISmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:42:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D94A464
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 11:17:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso6264816wmq.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Aug 2022 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=w/qiibypuEMZO6u9qM5aOQ5NBWUjjY86Sr5ieOQIKcY=;
        b=Ub9pLpWKvBOjkGF7Z23WK3Y+TGn6HwpmsyzgUGg2SiseyfAo6RdGHOfiRmatOiN2HP
         ik5stis9JUhdUTdT2+uRkM2UjLH0rWC+w92U43L7gGT7dxuOpwuzUzxxnXTNUwP2uAk4
         3TFsOrecoKleL79bjupAAEyTHVrbvvm9ccl76yL7ztKgmOs7Wjr1Q4xgX+bTXpH8Ngbt
         7bQvMmb9P3VTyB1sl008bDU9DMdMXosa47IIPvLBIIZ/ApQDBiUvcEu0kz9xIDYNL9Ej
         vTb7gWfsfcPZJ6QMHCG0q+PBvwcXExJkFDzJn+c1V8TyS//0a/yOIODVPgpyjyujml+q
         iJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=w/qiibypuEMZO6u9qM5aOQ5NBWUjjY86Sr5ieOQIKcY=;
        b=IqbKGNOGbHXmj2Dr/REroHW9uSPZskK/4YFNCRaW1LK9UNTMDbbTCDtTba6x+/dCl9
         6SafyB1YIZecC6gYlImz//sMmpjoClbigbkQjz2gWgBw9gayXdjSiAZr1jXd06H6DfOV
         ITHgUhAL4dwn+Juw+u65x+LZ/l86WnXuVjDjkpaVu0n2naU3PTLMtTvqPqbLxxjjf9yn
         Jj2tBTjHkXO/rGQxgdxR3G2G3+l9l7Zq00lX/lPgZf96naz8oWJCOeHmWrgom3tH46ct
         5BapqUG9OVZ0gbPNfMv76khQU73eFYzTE5dvRFZd0eoJijxuoNke9DgTlv0B5qlKSeNX
         00Rw==
X-Gm-Message-State: ACgBeo36iXwsbWc/pFzhuey84MH7Izg8qmhZqTLk2MbFiZilgHRGRDta
        cOU8Qk2nPgE0UmJwgoFptSosog==
X-Google-Smtp-Source: AA6agR6SmttNKqszjsz0UCdlS48jK1VgrDjJiKyz3glduegynV2vHdFLCY49JRzZcFW5KDSnCqerUQ==
X-Received: by 2002:a05:600c:4ec9:b0:3a5:a567:137f with SMTP id g9-20020a05600c4ec900b003a5a567137fmr712306wmq.46.1660069050814;
        Tue, 09 Aug 2022 11:17:30 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d4f05000000b002205a5de337sm14326219wru.102.2022.08.09.11.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:17:30 -0700 (PDT)
Date:   Tue, 9 Aug 2022 19:17:28 +0100
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
Message-ID: <YvKkuM6VMdMXBdYc@google.com>
References: <20220509131726.59664-1-tcs.kernel@gmail.com>
 <Ynl+kUGRYaovLc8q@sol.localdomain>
 <YsVYQAQ8ylvMQtR2@google.com>
 <Yta5+UOcK2rgBT6q@google.com>
 <YumdcdmPxqmx3AQc@sol.localdomain>
 <YvJ/XzuyWbZT2dlO@google.com>
 <YvKiELcu4FeGQMKI@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvKiELcu4FeGQMKI@gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 09 Aug 2022, Eric Biggers wrote:

> On Tue, Aug 09, 2022 at 04:38:07PM +0100, Lee Jones wrote:
> > > 	commit 353f7988dd8413c47718f7ca79c030b6fb62cfe5
> > > 	Author: Linus Torvalds <torvalds@linux-foundation.org>
> > > 	Date:   Tue Jul 19 11:09:01 2022 -0700
> > > 
> > > 	    watchqueue: make sure to serialize 'wqueue->defunct' properly
> > 
> > Thanks Eric, I'll back-port this one instead.
> > 
> 
> It's already in all LTS kernels that were affected (5.10 and later).

Right, but it's missing from a bunch of ACKs.

I'll sort it.  Thanks for all your help.

-- 
DEPRECATED: Please use lee@kernel.org
