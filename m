Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920382C3700
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 04:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgKYC44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 21:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgKYC44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:56:56 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D556C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 18:56:46 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id f16so902006otl.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 18:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+FWpHbem/CPK/Y2WEWVDIbPrtpce00d3aqKaeRn35jw=;
        b=u3ik/jOXlZPtuxZsymmgfKUaDyjjoSfE2RNE/6etm2mObkDL0KcbpGpsN3W0qUdmtN
         xxEiEPwiifMvSuQzP0luk3QNSRu99ftZMDeEsmLWWCSKYKWzrKqYM28K9URkcbKsQXEY
         Z8xkRxhzfSFYmR0JpOar1wKSuCWytUXJX8dTjXkRcHVjvZf8xjGW5PY4d5I5EDfziCTe
         JbSyEYifGpWuB2Qlux+LoD2IfjNipZpPKE4UuGRd6KVWK8/dP4neO1QXOp1h338gfh3g
         o0SqbxmUI9NY0sxppH7O/cS8kTG4jbViat5ED8qweuXWlCvuZX0yyG0Tdg6OdW4v5iuD
         swyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+FWpHbem/CPK/Y2WEWVDIbPrtpce00d3aqKaeRn35jw=;
        b=dorU732vYuyfhylEkEIhQwN8kJwDNlAptfJF8mPsM4d1VdvelWIMNXwha/xJgWqdLj
         4eEQgPZbE+hN0bycihprENUBZsH5SHKob64QracmwnJVwWKv3t+xIXSLSdkZKOdnHM1q
         VL1p/toOSf6Y6FNIcmDvIITjPWO+8TJMhgJlwhUeE/V0hXi+3ljJ6Np/65lJH2M6Yftn
         AwliiOZK7rGxVCK2ABTA26PxC66bqqG0bWpeCWL02wxz5EPE/de9JT7ccShhMFYnQKVh
         D/B/md3GOasVm9crotUjbHsdf+rsiUJTK/xbnXhQXxgf1NHnezb4a3pmm0RxbmLGdEXM
         iiOw==
X-Gm-Message-State: AOAM530MztjH90nrHJjuGfEDmd5C9eH6yookqiV2ibXxvNOB12cgTSHY
        FNNsajGZn1D9GL/KdrK4AAq4UA==
X-Google-Smtp-Source: ABdhPJzxVX94z8ieBTDByVy3UTLQt9z+rZTaAlxMAHgu+ZCnxtIpuauUnDVwsmyVJDy60Q5m8gthsw==
X-Received: by 2002:a9d:72dc:: with SMTP id d28mr1362880otk.110.1606273005462;
        Tue, 24 Nov 2020 18:56:45 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 19sm531313oth.63.2020.11.24.18.56.43
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 24 Nov 2020 18:56:44 -0800 (PST)
Date:   Tue, 24 Nov 2020 18:56:31 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
In-Reply-To: <alpine.LSU.2.11.2011241838400.3026@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2011241854140.3099@eggly.anvils>
References: <20201112212641.27837-1-willy@infradead.org> <alpine.LSU.2.11.2011160128001.1206@eggly.anvils> <20201117153947.GL29991@casper.infradead.org> <alpine.LSU.2.11.2011170820030.1014@eggly.anvils> <20201117191513.GV29991@casper.infradead.org>
 <20201117234302.GC29991@casper.infradead.org> <20201125023234.GH4327@casper.infradead.org> <alpine.LSU.2.11.2011241838400.3026@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 24 Nov 2020, Hugh Dickins wrote:
> On Wed, 25 Nov 2020, Matthew Wilcox wrote:
> > On Tue, Nov 17, 2020 at 11:43:02PM +0000, Matthew Wilcox wrote:
> > > On Tue, Nov 17, 2020 at 07:15:13PM +0000, Matthew Wilcox wrote:
> > > > I find both of these functions exceptionally confusing.  Does this
> > > > make it easier to understand?
> > > 
> > > Never mind, this is buggy.  I'll send something better tomorrow.
> > 
> > That took a week, not a day.  *sigh*.  At least this is shorter.
> 
> Thanks, I'll give it a try (along with the other 4, on top of the 12:

s/12/16/

> maybe on -rc5, maybe on today's mmotm, I'll decide that later).
> 
> Shorter you say, that's good: I was disheartened by the way it got
> more complicated, after your initial truncate_inode_partial_page()
> neatness.  Any hints on what was wrong with my simple fixup to that?
> (But I didn't spend any more time trying to prove or disprove it.)
> 
> Hugh
> 
