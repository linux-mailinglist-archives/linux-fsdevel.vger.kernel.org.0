Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC8223175F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 03:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgG2Bni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 21:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730207AbgG2Bnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 21:43:37 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA17C061794;
        Tue, 28 Jul 2020 18:43:37 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id l23so20832153qkk.0;
        Tue, 28 Jul 2020 18:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FCWquvs7eFY8Ql1yet6xeesuqFfCrj0kYxiNmZ1t4Q8=;
        b=tbLZicJxoYz8MkVoPSZAJ/dU5mMBuAgzLMXUmo+/MAOWZ1C8ia4OXpmC6Nv1l5nYRN
         rYAYhZzaGW12GrvtTp5jCE/g4DUe1ku8uIFEU8xb8t96aqQqbZa0l8XXYpGu2+Xq+ikz
         xBNAc5d9oroIb29LbXoSlp6sHZNpnmjjlP+Pp9utQwYi0KxqXtlzskCVfAwPf+dYkq03
         vIs3WXqLhjdFsxiJ2nb1ueyqCjB6yBBNvdd08xXQX0ChlHymK/CmEQa8BQPGfZTIM82v
         rClu50ffxDSD3ixt3wZSWm1fz4AH/Czd96mX5QgaPHaokMXgfcVu4ts0NGKlQ/JKn2TC
         r8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FCWquvs7eFY8Ql1yet6xeesuqFfCrj0kYxiNmZ1t4Q8=;
        b=VRvBFy0/bBOppa4Cb46K1CYMITP+NU7cysoh14Hi5kQQMDTbua59Kc3G339WQo/ZDS
         TzLJVrG83GeYwsPGUrt/Ug/c0iNi0dt3RcKLzY0lcbZXmMHwWpxgdS/Iw0hF7imFYnBh
         JuaH1JR56WnnH6bSDffkzVteeZfKFngyAFzOVUOJ8aLJYWiMrDfeT0+ZiJz85tQXWzNU
         WkJivdTlvXYFF4kqib+lWH+6RGzSo9gYz9EPlD8a+nyux8QQfARuSrGSvlKRB68yKVYN
         C/Ui4BU8+HUnzJ3xelmChY8MeVcdiSHan1HYZ5ISJ96w+20QEJUJTpQh5EN+xkfYV171
         wLNw==
X-Gm-Message-State: AOAM5302n1NsHQQCC16o6g0IPaed9wOnFthSKiLJcYd3Vv2nrhXMjV48
        Zpxgf56azZLgwoqLeggt9Yo=
X-Google-Smtp-Source: ABdhPJzf8DD6hViotHVAt7rYHvQ7qTe+CD2tTQe/PzUAfcZKASMF1z5SbEGkOcaSIPzw3XRlLNB/pA==
X-Received: by 2002:a05:620a:4045:: with SMTP id i5mr18645223qko.108.1595987015511;
        Tue, 28 Jul 2020 18:43:35 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id x67sm401336qke.136.2020.07.28.18.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 18:43:34 -0700 (PDT)
Date:   Tue, 28 Jul 2020 18:43:33 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2020-07-27-18-18 uploaded (mm/page_alloc.c)
Message-ID: <20200729014333.GA33042@ubuntu-n2-xlarge-x86>
References: <20200728011914.S-8vAYUK0%akpm@linux-foundation.org>
 <ae87385b-f830-dbdf-ebc7-1afb82a7fed0@infradead.org>
 <20200728145553.2a69fa2080de01922b3a74e0@linux-foundation.org>
 <048cef07-ad4b-8788-94a4-e144de731ab6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <048cef07-ad4b-8788-94a4-e144de731ab6@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 03:39:21PM -0700, Randy Dunlap wrote:
> On 7/28/20 2:55 PM, Andrew Morton wrote:
> > On Tue, 28 Jul 2020 05:33:58 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> >> On 7/27/20 6:19 PM, Andrew Morton wrote:
> >>> The mm-of-the-moment snapshot 2020-07-27-18-18 has been uploaded to
> >>>
> >>>    http://www.ozlabs.org/~akpm/mmotm/
> 
> 
> >> on x86_64:
> >>
> >> ../mm/page_alloc.c:8355:48: warning: ‘struct compact_control’ declared inside parameter list will not be visible outside of this definition or declaration
> >>  static int __alloc_contig_migrate_range(struct compact_control *cc,
> >>                                                 ^~~~~~~~~~~~~~~
> > 
> > As is usually the case with your reports, I can't figure out how to
> > reproduce it.  I copy then .config, run `make oldconfig' (need to hit
> > enter a zillion times because the .config is whacky) then the build
> > succeeds.  What's the secret?
> 
> I was not aware that there was a problem. cp .config and make oldconfig
> should be sufficient -- and I don't understand why you would need to hit
> enter many times.
> 
> I repeated this on my system without having to answer any oldconfig prompts
> and still got build errors.
> 
> There is no secret that I know of, but it would be good to get to the
> bottom of this problem.
> 
> -- 
> ~Randy
> 

I usually do 'olddefconfig', which is the same as oldconfig but it
selects the default value of the symbols that are new. This usually
happens for me if I am flipping around in different trees like mainline
and next, where there might be new or different symbols between them.

Cheers,
Nathan
