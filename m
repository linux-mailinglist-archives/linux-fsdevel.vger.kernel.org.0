Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5F05A1E43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 03:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244573AbiHZBhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 21:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244189AbiHZBhf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:37:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA5AC9EBF
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 18:37:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z25so170658lfr.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 18:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GKNQ/ICM71YlRfPoSJ/fDt8fKEwvuPRl/SEMWxgkQ9I=;
        b=2MgqWIXfIoCsyZeKzmpkpSkI3FT26jCW664f3o/ogXsI7DFddojX+dMZp/efl5IU0/
         WaHwrtnlaQqHSl3KlgfxIHex9TBZCyDUySwOHUV5LS83DKpibf18ZxyoWeRtQi/IoAIF
         1CJnOMo/E0eRoU7JB7eqPvkw0QS8EmBaFqARl+442hKskOyv+85c+NvWxtiHRQT856LD
         dbPVtt9iJXqbVYjlBzQW3oEg8pTbEaAyXGEUun/8bpm8leotm2QmuY0+0cA6DCJUUELE
         6gMFLMmD86CdKCRfxsFUxX/YQHtmCtOGngddFsgbJK2csf0E7XxWvlHlK1CfjSATw6VP
         qxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GKNQ/ICM71YlRfPoSJ/fDt8fKEwvuPRl/SEMWxgkQ9I=;
        b=NRnwBrjeUdCJQ1kOotV5OA+Glz3wM9Idc3/JUhmLFtGXdqrXNNh0pg20g0Um8V3WCc
         HXZocWgw1yPnGZqre0qLO3ZNTyiCColoxZcnyWJS+HRo73R1BX6lOZNP4weYKIFypMNB
         QQ7kkzFa2zyzfT1YGgaVNCXGUMbuSeyNuqP92TWFFZEkTdq9VfJI4rycJJFQ42UFvRBs
         mCqA+UVV7B2UYtMG8T/Fi8lFEaZAyQcrLtGZkaT55VtAkWuM/MLR0hFF9+o9kX3s70eo
         BEZ9MrIAxbTz0xMnDm10J28d0CU8fUc3m/9XD1J5sRT4LsfBgGuEZWmFPgRK1DYEBaj6
         ctFw==
X-Gm-Message-State: ACgBeo3I1AEqKlrGWzJt+MGfe4FohOUXhGAYvd+FxTnNwX/7ryY/XoEk
        fMhFpffQHSF4GoWRsiifnUFt+x98v1O4Hllh6oUzJw==
X-Google-Smtp-Source: AA6agR4AR6FyNb5iDfumWDUQyjoEAmPVsHwBUrXQ5m1yUa65MpdySD9fBoYVkGEA8ehm6LQvnSPqL/zfpT2Py88xr+w=
X-Received: by 2002:a19:5e02:0:b0:48b:1870:dc4 with SMTP id
 s2-20020a195e02000000b0048b18700dc4mr2002932lfb.4.1661477851560; Thu, 25 Aug
 2022 18:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220817065200.11543-1-yinxin.x@bytedance.com>
 <3713582.1661336736@warthog.procyon.org.uk> <CAK896s4uuU=K5Gau9J79GK_pWQuihyfXUoZCq0iFbWt9fHLudQ@mail.gmail.com>
 <3791693.1661438076@warthog.procyon.org.uk>
In-Reply-To: <3791693.1661438076@warthog.procyon.org.uk>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Fri, 26 Aug 2022 09:37:12 +0800
Message-ID: <CAK896s6E_u34XKF6zCu9ecYCRs6_Po=po=0npnHRp+b6wWn7Uw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] cachefiles: make on-demand request
 distribution fairer
To:     David Howells <dhowells@redhat.com>
Cc:     xiang@kernel.org, jefflexu@linux.alibaba.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        zhujia.zj@bytedance.com, Yongqing Li <liyongqing@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 25, 2022 at 10:34 PM David Howells <dhowells@redhat.com> wrote:
>
> Xin Yin <yinxin.x@bytedance.com> wrote:
>
> > > Can you give me a Fixes: line please?
> > >
> > Sure , I will send a V2 patch and add the Fixes line.
>
> Just giving me a Fixes line would do.  I can insert it.
>

Yeah, many thanks , the fixes line would be:
Fixes: c8383054506c ("cachefiles: notify the user daemon when looking
up cookie")

Thanks,
Xin Yin

> David
>
