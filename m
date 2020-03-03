Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04658178456
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 21:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbgCCUxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 15:53:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54745 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731796AbgCCUxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:53:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id i9so3462681wml.4;
        Tue, 03 Mar 2020 12:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1rquLtYOK96Itl/9OGMha3jcJHvengNZ7pGMJ9cEeFw=;
        b=g3rbTmYQNJp3n8wZSN5VEXpIckbNQkRAO4e1wy2YwgeC2o2SQ45fstB2OfMeIRpjme
         H+p1bVO5SX/u53hb4ToLMJSLhrbbBltiEaWc3XCI2tveZh5kprt5dDj6Unvhiod4qUgQ
         wZAWIJrZlAKoXqSFGCumuh+gvofQ/WxQks4Q3TjCRd/2IG69AgpbonKCHZufYJgshZA7
         oo1qahrzVJgjqH0uxeAZu4AFd2HMcIO1jtGvrEnIJ44CawnFoCBy7fbqEKj/kUPSWv4t
         qpiDmCcSrxWsrO+q1UIt5MFY9Wxp/dOnaNNGW1NgkocLIWXgmHWGaOHIVFqA7MtfnXV6
         O+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1rquLtYOK96Itl/9OGMha3jcJHvengNZ7pGMJ9cEeFw=;
        b=f8tyk6W3tWo8Nlu3vNRfu7jexf8UAcyEeUq8+4VifbgbP4zuwhSWR0tyxVvMMg2K+x
         EoHRKAM2I0U8LwNpDVu29PRXEXODstpweITR47BqcgEgXlg12sVFlU24uvjdhuJjveqh
         +iSH8H/9qLM9xUl7Ncd7XjJim/j62wO057GpbNqQ53bDhANqMXz30HMFh4omsiMSMUPs
         7Ofhz9NlQk7hluLJzHTihHbmr3e+zpWj6Mjq/jFYX8hf79eVoNv3mGW7hL81r6cMaWct
         Xsl/cAZpewdxwnBPlXUHPY2BdE4EzwwHzED6XRqt7FjBm1014EfO3zG4mpKW+2LbgYt8
         HiPw==
X-Gm-Message-State: ANhLgQ09FmLIXCzc5BOJqlD7AwLGMi8gRMXem7Cnxs71ellAW5LvgFZP
        iGLCRSJ9H0Yh5vHPTXJLt2XOckA=
X-Google-Smtp-Source: ADFU+vsmVFcd3gGI7F5NaonuRODLvNqfKOkEdWwoMjw8DpOjsKD9rfCNed6XCZEUtCQa1pjSrhYRPw==
X-Received: by 2002:a1c:2358:: with SMTP id j85mr363807wmj.137.1583268785739;
        Tue, 03 Mar 2020 12:53:05 -0800 (PST)
Received: from avx2 ([46.53.249.49])
        by smtp.gmail.com with ESMTPSA id n3sm7805868wrv.91.2020.03.03.12.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 12:53:05 -0800 (PST)
Date:   Tue, 3 Mar 2020 23:53:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] proc: Use ppos instead of m->version
Message-ID: <20200303205303.GA10772@avx2>
References: <20200229165910.24605-1-willy@infradead.org>
 <20200229165910.24605-4-willy@infradead.org>
 <20200303195529.GA17768@avx2>
 <20200303202923.GT29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200303202923.GT29971@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 12:29:23PM -0800, Matthew Wilcox wrote:
> On Tue, Mar 03, 2020 at 10:55:29PM +0300, Alexey Dobriyan wrote:
> > On Sat, Feb 29, 2020 at 08:59:08AM -0800, Matthew Wilcox wrote:
> > > -static void *m_next(struct seq_file *m, void *v, loff_t *pos)
> > > +static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> > 
> > This looks like hungarian notation.
> 
> It's the standard naming convention used throughout the VFS.  loff_t is
> pos, loff_t * is ppos.
> 
> $ git grep 'loff_t \*' fs/*.c |wc
>      77     556    5233
> $ git grep 'loff_t \*ppos' fs/*.c |wc
>      43     309    2974
> $ git grep 'loff_t \*pos' fs/*.c |wc
>      22     168    1524

Yes, people copy-pasted terrible thing for years!
Oh well, whatever...
