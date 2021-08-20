Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BFC3F2D62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 15:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbhHTNsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 09:48:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231854AbhHTNsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629467277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4VaO/ZlpDnEtWAJ02e00kwDAMMR+6kRDVmQuNZWgk0=;
        b=D6SATk9LT3KkHBBS1Gik/0ohUYvY6Ec/Su59ofc8gmRf5wuotcO58+L+3EZL59/bQRrpKn
        BdLtaozN24uVmzyWPWtCGTRWDLl+MIVevUxKvFlwJZpQUo+LDLifR7oRnLpHmTPziV1az6
        AUC1t6SE4OX1T98iM+NTCb3aXwKEU5o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-zJekVjUJMFuSXdoVFAl4Ug-1; Fri, 20 Aug 2021 09:47:56 -0400
X-MC-Unique: zJekVjUJMFuSXdoVFAl4Ug-1
Received: by mail-ed1-f69.google.com with SMTP id e3-20020a50ec830000b02903be5be2fc73so4547882edr.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 06:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=S4VaO/ZlpDnEtWAJ02e00kwDAMMR+6kRDVmQuNZWgk0=;
        b=IQdQ7CuGs45Us0F5jy/K+b0lJGBrJDXSmgTLVF2QIeXobsZkz2JhdMNvO7YSjEF9lH
         aUVfEGN3rvZ0lIibtoa/2hs54RFlF2QFuF/2MAY5lRSLgX2EZW7AsMprLUytbKWGDHIN
         dtzM4EkdkRnRVmqxjEY2pII4Hw7vtAM1FAf3/zkqJxl9ZgUjHeNGci9PVP7ZjnN6EvWl
         N7D0N2vrlJuPmDD23YhnlWs4zTpSCxMMp2ZebFbYzAg0pVyvjAPydLL7frx+rlvheZGL
         V8SCzP8HMmrfDtvYWl+7N9Dk48pFzyHsjGmNGhku1ASdjy6zk0flny3qTxqPbg1yztCA
         P9mw==
X-Gm-Message-State: AOAM532eAALSzUwnc1vwpE9zBJ0UABAPG+250VU86i6pk+wRd6e7S1qA
        Qx4BaRzj535GcAcdx67Gbz7mSwgQLmblSYSg6MVLhb4Ed1yK2Mq7IlahsxCid2+H2+rZsTH6xQp
        a/8N73ZuW6ZZs/FWxbo2ysAOCtw==
X-Received: by 2002:a17:906:c52:: with SMTP id t18mr17733331ejf.148.1629467275426;
        Fri, 20 Aug 2021 06:47:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxGgzFzFSgxvMjImNOJovDn+MR8vHdHX44QmGlTVPfBl8l/23tH/xJ53AhweH4OH2mV6s+mw==
X-Received: by 2002:a17:906:c52:: with SMTP id t18mr17733309ejf.148.1629467275222;
        Fri, 20 Aug 2021 06:47:55 -0700 (PDT)
Received: from 0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa (0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:ffda:0:2059:8730:b2:c370])
        by smtp.gmail.com with ESMTPSA id e22sm3641397edu.35.2021.08.20.06.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 06:47:54 -0700 (PDT)
Message-ID: <d5fbfeff64cee4a2045e4e53abbd205618888044.camel@redhat.com>
Subject: Re: [Cluster-devel] [PATCH v6 10/19] gfs2: Introduce flag for glock
 holder auto-demotion
From:   Steven Whitehouse <swhiteho@redhat.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Date:   Fri, 20 Aug 2021 14:47:54 +0100
In-Reply-To: <CAHc6FU7jz9z9FEu3gY0S2A2Rv6cQJzp7p_5NOnU3b8Zpz+QsVg@mail.gmail.com>
References: <20210819194102.1491495-1-agruenba@redhat.com>
         <20210819194102.1491495-11-agruenba@redhat.com>
         <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com>
         <CAHc6FU7jz9z9FEu3gY0S2A2Rv6cQJzp7p_5NOnU3b8Zpz+QsVg@mail.gmail.com>
Organization: Red Hat UK Ltd
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Fri, 2021-08-20 at 15:17 +0200, Andreas Gruenbacher wrote:
> On Fri, Aug 20, 2021 at 11:35 AM Steven Whitehouse <
> swhiteho@redhat.com> wrote:
> > On Thu, 2021-08-19 at 21:40 +0200, Andreas Gruenbacher wrote:
> > > From: Bob Peterson <rpeterso@redhat.com>
> > > 
> > > This patch introduces a new HIF_MAY_DEMOTE flag and
> > > infrastructure
> > > that will allow glocks to be demoted automatically on locking
> > > conflicts.
> > > When a locking request comes in that isn't compatible with the
> > > locking
> > > state of a holder and that holder has the HIF_MAY_DEMOTE flag
> > > set, the
> > > holder will be demoted automatically before the incoming locking
> > > request
> > > is granted.
> > 
> > I'm not sure I understand what is going on here. When there are
> > locking
> > conflicts we generate call backs and those result in glock
> > demotion.
> > There is no need for a flag to indicate that I think, since it is
> > the
> > default behaviour anyway. Or perhaps the explanation is just a bit
> > confusing...
> 
> When a glock has active holders (with the HIF_HOLDER flag set), the
> glock won't be demoted to a state incompatible with any of those
> holders.
> 
Ok, that is a much clearer explanation of what the patch does. Active
holders have always prevented demotions previously.

> > > Processes that allow a glock holder to be taken away indicate
> > > this by
> > > calling gfs2_holder_allow_demote().  When they need the glock
> > > again,
> > > they call gfs2_holder_disallow_demote() and then they check if
> > > the
> > > holder is still queued: if it is, they're still holding the
> > > glock; if
> > > it isn't, they need to re-acquire the glock.
> > > 
> > > This allows processes to hang on to locks that could become part
> > > of a
> > > cyclic locking dependency.  The locks will be given up when a
> > > (rare)
> > > conflicting locking request occurs, and don't need to be given up
> > > prematurely.
> > 
> > This seems backwards to me. We already have the glock layer cache
> > the
> > locks until they are required by another node. We also have the min
> > hold time to make sure that we don't bounce locks too much. So what
> > is
> > the problem that you are trying to solve here I wonder?
> 
> This solves the problem of faulting in pages during read and write
> operations: on the one hand, we want to hold the inode glock across
> those operations. On the other hand, those operations may fault in
> pages, which may require taking the same or other inode glocks,
> directly or indirectly, which can deadlock.
> 
> So before we fault in pages, we indicate with
> gfs2_holder_allow_demote(gh) that we can cope if the glock is taken
> away from us. After faulting in the pages, we indicate with
> gfs2_holder_disallow_demote(gh) that we now actually need the glock
> again. At that point, we either still have the glock (i.e., the
> holder
> is still queued and it has the HIF_HOLDER flag set), or we don't.
> 
> The different kinds of read and write operations differ in how they
> handle the latter case:
> 
>  * When a buffered read or write loses the inode glock, it returns a
> short result. This
>    prevents torn writes and reading things that have never existed on
> disk in that form.
> 
>  * When a direct read or write loses the inode glock, it re-acquires
> it before resuming
>    the operation. Direct I/O is not expected to return partial
> results
> and doesn't provide
>    any kind of synchronization among processes.
> 
> We could solve this kind of problem in other ways, for example, by
> keeping a glock generation number, dropping the glock before faulting
> in pages, re-acquiring it afterwards, and checking if the generation
> number has changed. This would still be an additional piece of glock
> infrastructure, but more heavyweight than the HIF_MAY_DEMOTE flag
> which uses the existing glock holder infrastructure.

This is working towards the "why" but could probably be summarised a
bit more. We always used to manage to avoid holding fs locks when
copying to/from userspace to avoid these complications. If that is no
longer possible then it would be good to document what the new
expectations are somewhere suitable in Documentation/filesystems/...
just so we make sure it is clear what the new system is, and everyone
will be on the same page,

Steve.



