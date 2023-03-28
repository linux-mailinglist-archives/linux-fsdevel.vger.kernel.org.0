Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4CB6CCA3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 20:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjC1StP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 14:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjC1StN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:49:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000ABA8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680029304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RB+9it/G78fglttzmQ9+/zlvyRf1knohCfLfnFxrA1Q=;
        b=TET6YoYmChYPqODF048VjJyiTvWticsxTnfMx0vXsMdO3RKcyO065BK34Mtq42kkzfbQy/
        yKu6XNr4we4QFmeRvFvAF7nEqIqzH8BCC39cPHVTE7+uD8p7McGYOHLOFbUk0NnR5Bhg1c
        zaU6x9bLNDFNSl5+unB2dnz/tR/kQes=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-uIQJEqGNMuiBSS2vECEssg-1; Tue, 28 Mar 2023 14:48:21 -0400
X-MC-Unique: uIQJEqGNMuiBSS2vECEssg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76C9E85A5B1;
        Tue, 28 Mar 2023 18:48:20 +0000 (UTC)
Received: from ws.net.home (ovpn-192-12.brq.redhat.com [10.40.192.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B97B40C6E67;
        Tue, 28 Mar 2023 18:48:17 +0000 (UTC)
Date:   Tue, 28 Mar 2023 20:48:15 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steve French <smfrench@gmail.com>,
        Tom Moyer <tom.moyer@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Paulo Alcantara <pc@cjr.nz>,
        Leif Sahlberg <lsahlber@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        NeilBrown <neilb@suse.com>, Steve Dickson <steved@redhat.com>
Subject: Re: [RFC PATCH] Legacy mount option "sloppy" support
Message-ID: <20230328184815.ycgxqen7difgnjt3@ws.net.home>
References: <167963629788.253682.5439077048343743982.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167963629788.253682.5439077048343743982.stgit@donald.themaw.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 01:39:09PM +0800, Ian Kent wrote:
> Karel do you find what I'm saying is accurate?
> Do you think we will be able to get rid of the sloppy option over
> time with the move to use the mount API?

The question is what we're talking about :-)

For mount(8) and libmount, there is nothing like the "sloppy" mount option.

If you use it in your fstab or as "mount -o sloppy" on the command line,
then it's used as any other fs-specific mount option; the library copies
the string to mount(2) or fsconfig(2) syscall. The library has no clue 
what the string means (it's the same as "mount -o foobar").

But there is another "sloppy" :-) The command line argument, "mount -s".

This argument is not internally used by libmount or mount(8), but it's
repeated on /sbin/mount.<type> command lines (e.g., "mount -t nfs -s"
means "/sbin/mount.nfs -s").

I guess more interesting is mount.nfs, where both "-s" and "sloppy" lives
together. The mount.nfs uses this option to be tolerant when parsing mount
options string, and it also seems it converts "-s" to "sloppy" string for
mount syscall.

So, for mount(8)/libmount, digging a grave for the "sloppy" will be trivial.

All I need is to add a note about depreciation to the man page and later
remove "-s" from /sbin/mount.<type> command line.

SteveD (in CC:) will comment on it from the NFS point of view because the
real fun happens there :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

