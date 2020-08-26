Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3C0253390
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgHZPZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 11:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgHZPZE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:25:04 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F356C0613ED
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 08:25:02 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id l13so859347qvt.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3jCdtk/ZURSNuEFDfKhXe1ymBpf3lit0hQaqnak8Pck=;
        b=PPKe2c9w7o8mKfxppP3ImoOQWtbEiAyVzoSGux9dLmTh0TtWAU7mAYN/eqGA8il0eR
         IRb7JnwpNPiDNFsDrr+7EEKK3VJVCRM3gNXGLp+/ZfSy9bFA0SjOWwy3ITc5/ZpotjXS
         +ONIyx9EQf80B7pWXlNfQE+YSPNGFiRd3DmKfdbebnTq9InXXX63O60Yjb8ilkgnbS5m
         SpaKx4vj3dweaM8D3DT3M9BFS4gZHeCWDCEeZYg7PFSlIzjkUFqXzr9L1pnGArRoWcEc
         wIPbtRVYvENkLXpQp33xNU8fvZ0AY2P7CaA4UUgmnJbgfF++p1TVHSRBX9a/sCwIN2jj
         OIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3jCdtk/ZURSNuEFDfKhXe1ymBpf3lit0hQaqnak8Pck=;
        b=Zkd4q5+jOGu/FoVSHM3ApVPsJQdqpc+LRIfRFzvDpaClXNKH8DqPcQT+b+pGyObGjB
         9+NSEBAXELmDNUj9GRBblxHlmUshZi31NQQhpWidbIUCtBUfnN9JXdYwDkpBwTCOULKi
         2KRE58GyhQeSy01ioX8VKi6hr0DDyCVZ61fQwVQbSQcff7e4YCCCfZMXoms+kvr9vetV
         bPWSgSZ6AyWCKet5yYzQRTiqJJLsAgmrld5q4dLBirF0Z7H3uYwWAJ4BurjE4gfDCkyG
         Fwi4obFXHVhkyTJzRzaXG5Kgknb3eMFIk3aEVmOQyfDGPR2eGu8cu2alxoGoruFK5gKl
         aYuw==
X-Gm-Message-State: AOAM531tFWKcZvxXtZvtMqsusDyP2kOKNfND9mnWxmmulx4iYBvUL+nP
        o/u9B8TsSN1TBp7mN6v4fqh7ig==
X-Google-Smtp-Source: ABdhPJybSAIDosW5z0AAAsSDqg7kgtB/dyNQZnTsV+MunsOMYGeYiMt4qloptISx1U+AUpUU4zFMfw==
X-Received: by 2002:ad4:4aa5:: with SMTP id i5mr14499134qvx.179.1598455501966;
        Wed, 26 Aug 2020 08:25:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:412a])
        by smtp.gmail.com with ESMTPSA id f193sm1842958qke.101.2020.08.26.08.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 08:25:00 -0700 (PDT)
Date:   Wed, 26 Aug 2020 11:23:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2020-08-24-16-06 uploaded
Message-ID: <20200826152346.GF988805@cmpxchg.org>
References: <20200824230725.8gXQoJFD-%akpm@linux-foundation.org>
 <20200825084543.GA16605@linux>
 <20200825173021.fcf20a4f3043ed5d5b4ac3b5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825173021.fcf20a4f3043ed5d5b4ac3b5@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 05:30:21PM -0700, Andrew Morton wrote:
> On Tue, 25 Aug 2020 10:45:48 +0200 Oscar Salvador <osalvador@suse.de> wrote:
> 
> > On Mon, Aug 24, 2020 at 04:07:25PM -0700, akpm@linux-foundation.org wrote:
> > > A full copy of the full kernel tree with the linux-next and mmotm patches
> > > already applied is available through git within an hour of the mmotm
> > > release.  Individual mmotm releases are tagged.  The master branch always
> > > points to the latest release, so it's constantly rebasing.
> > > 
> > > 	https://github.com/hnaz/linux-mm
> > 
> > Is it me or this is out of sync?
> > 
> 
> Seems that way.  Maybe Johannes's script needs a new battery?

It looks like github had the hiccups yesterday:

Connection to github.com closed by remote host.
fatal: the remote end hung up unexpectedly
fatal: the remote end hung up unexpectedly

But it's uptodate now.
