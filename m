Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AD61E240D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 16:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgEZO2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 10:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgEZO2I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 10:28:08 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB48C03E96D;
        Tue, 26 May 2020 07:28:08 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f18so3941855qkh.1;
        Tue, 26 May 2020 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0TJ6yYccZvVBdf4f/G2i6OowH5C25Z8m9Ap0zEnVgR8=;
        b=TLMKcn3xE73A18nE6utedMS8Vz8HXK+b0q/Divfxr42WLvfCj1VnejFo7V5BPdLF0q
         W+VJW80hsx5pkyn2afaGJzSd1NY9lzi/WflZh7Okd/ujLflmIzup/UUhAjVe3hjLW/ov
         /ckbc/JaidWP13F1n6QRu3E3MBXNO+SL6qBL9nAMf03UnJq5zUo+MGasn74WqYB3nHlM
         RMvAQzvfJ3xtHcnQf7mOLh7b54gRFUEIEGn2cQ5cWzw7drZMeoCaq8lvxlN5DiCjmw1j
         OWij/qP1w+bHGLFTVBEmayKa6pI5nJLWTt6wzU97k3DMGp051NXEEKMYkQDFm1nLdmm9
         mfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0TJ6yYccZvVBdf4f/G2i6OowH5C25Z8m9Ap0zEnVgR8=;
        b=sWSG7rVHI6UhGH2cnK87AAiwlT/M2F1QHjCYfc9SX94bo+TKyxNOuCd6QDUis2mvGf
         QNVihmYN3HqmLU5TqKOyJtgs+RKzoZt3AAd9+934j3JF67QnypK6NMR35XWkhcxOf/50
         e2W31VfsON/dvS5hoJxlxYIpSnaDw00DoJFecTTKvfTBleUprwlPsi6EJPiJG+oxiuQQ
         ynuwr0tX9l0Q6o/8DgJd6SKFSW6NiiZ6APZc4GwxKHy9YrXXX16S4TVbNXSHTclNAkCc
         Yic+aekVfdeAt9dh5MhlIimDQ5244wMaykDU6lnsZu1JM/gPN2X7QKqYX3IKX3kXevwM
         Phog==
X-Gm-Message-State: AOAM532tGdnh9n/DpdPjWL5A6R70E8FMF5pN4C4vJBcpOLi90d7oaiZ/
        S00JNO2l72xVBSiiI7okChI=
X-Google-Smtp-Source: ABdhPJyK3oMuyeJ+F6B+ZijqpLzxAJ4vgdbS/Dm2ZGwMW4CXq3uWQNM1w7dewvLbX9tlS3HD2SWAuA==
X-Received: by 2002:a37:78c1:: with SMTP id t184mr1585988qkc.213.1590503287516;
        Tue, 26 May 2020 07:28:07 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:6991])
        by smtp.gmail.com with ESMTPSA id i14sm4786794qkl.105.2020.05.26.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 07:28:06 -0700 (PDT)
Date:   Tue, 26 May 2020 10:28:03 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v5 0/4] Charge loop device i/o to issuing cgroup
Message-ID: <20200526142803.GA1061@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20200428161355.6377-1-schatzberg.dan@gmail.com>
 <20200512132521.GA28700@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
 <20200512133545.GA26535@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512133545.GA26535@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 06:35:45AM -0700, Christoph Hellwig wrote:
> On Tue, May 12, 2020 at 09:25:21AM -0400, Dan Schatzberg wrote:
> > Seems like discussion on this patch series has died down. There's been
> > a concern raised that we could generalize infrastructure across loop,
> > md, etc. This may be possible, in the future, but it isn't clear to me
> > how this would look like. I'm inclined to fix the existing issue with
> > loop devices now (this is a problem we hit at FB) and address
> > consolidation with other cases if and when those are addressed.
> > 
> > Jens, you've expressed interest in seeing this series go through the
> > block tree so I'm interested in your perspective here. Barring any
> > concrete implementation bugs, would you be okay merging this version?
> 
> Independ of any higher level issues you need to sort out the spinlock
> mess I pointed out.

Will do - I'll split out the lock-use refactor into a separate
patch. Do you have particular concerns about re-using the existing
spinlock? Its existing use is not contended so I didn't see any harm
in extending its use. I'll add this justification to the commit
message as well, but I'm tempted to leave the re-use as is instead of
creating a new lock.
