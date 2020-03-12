Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69411836B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 17:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgCLQ4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 12:56:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30648 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726510AbgCLQ4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584032213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tC/dXDRVsRvobj4efL+zW9X6MF6Isbjq0hH6zkUllc0=;
        b=iGz00CsDsOSvCrioRebtyV4f2IOJYP3KC5xY9kGZg4uB3KTgL6Pye+M1MphUEo1bOcmC3k
        E2npLnQ2OsbGa5Knb3NDk/kQVX7mMfphYB2BbmOUeF7ar8sgcOVEmdwnKG8xW2JHseA3uC
        VwnCY6F34fduUPEItB3Nwnb+8cGnsM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-XTtHN6DkO069iLfk00j1xg-1; Thu, 12 Mar 2020 12:56:50 -0400
X-MC-Unique: XTtHN6DkO069iLfk00j1xg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20DAF1060DF7;
        Thu, 12 Mar 2020 16:56:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90D01194BB;
        Thu, 12 Mar 2020 16:56:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
References: <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com> <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk> <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk> <20200310005549.adrn3yf4mbljc5f6@yavin> <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com> <580352.1583825105@warthog.procyon.org.uk> <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com> <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Stefan Metzmacher <metze@samba.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1147627.1584032201.1@warthog.procyon.org.uk>
Date:   Thu, 12 Mar 2020 16:56:41 +0000
Message-ID: <1147628.1584032201@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > The whole discussion was triggered by the introduction of a completely
> > new fsinfo() call:
> >
> > Would you propose to have 'at_flags' and 'resolve_flags' passed in here?
> 
> Yes, I think that would be the way to go.

Okay, I can do that.

Any thoughts on which set of flags should override the other?  If we're making
RESOLVE_* flags the new definitive interface, then I feel they should probably
override the AT_* flags where there's a conflict, ie. RESOLVE_NO_SYMLINKS
should override AT_SYMLINK_FOLLOW for example.

David

