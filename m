Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5949C1992AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 11:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgCaJtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 05:49:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24550 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729425AbgCaJtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585648180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z4v/YtSm7khSMtma48XmYXMI66/O3qRGCFmAxLMn+2U=;
        b=Smmq116QZwu0eJs42b0svhzutApWf3xK/lXdubTmIZmITRlndkWn2S4m3oHw/6Mb857gZZ
        cFv6lxWec24nhwzSRAjG+P9Ao9QPQfg7M7fPf54Hbk9yNd7sjkDsfHu9TemFL+UOZeKUg+
        8us+zBC5RNRHkWNqPnPKI+dpJeCorRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-wsmh7QxlMIexmPjb_Lr0Pw-1; Tue, 31 Mar 2020 05:49:38 -0400
X-MC-Unique: wsmh7QxlMIexmPjb_Lr0Pw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F5621005509;
        Tue, 31 Mar 2020 09:49:36 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB62598A21;
        Tue, 31 Mar 2020 09:49:32 +0000 (UTC)
Date:   Tue, 31 Mar 2020 11:49:30 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200331094930.3aipm3zrydpqqhms@ws.net.home>
References: <1445647.1585576702@warthog.procyon.org.uk>
 <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
 <20200331083430.kserp35qabnxvths@ws.net.home>
 <CAJfpegsNpabFwoLL8HffNbi_4DuGMn4eYpFc6n7223UFnEPAbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsNpabFwoLL8HffNbi_4DuGMn4eYpFc6n7223UFnEPAbA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:56:35AM +0200, Miklos Szeredi wrote:
> I think we are approaching this from the wrong end.   Let's just
> ignore all of the proposed interfaces for now and only concentrate on
> what this will be used for.
> 
> Start with a set of use cases by all interested parties.  E.g.
> 
>  - systemd wants to keep track attached mounts in a namespace, as well
> as new detached mounts created by fsmount()
> 
>  - systemd need to keep information (such as parent, children, mount
> flags, fs options, etc) up to date on any change of topology or
> attributes.
> 
>  - util linux needs to display the topology and state of mounts in the
> system that corresponds to a consistent state that set of mounts

  - like systemd we also need in mount/umount to query one mountpoint
  rather than parse all /proc/self/mountinfo

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

