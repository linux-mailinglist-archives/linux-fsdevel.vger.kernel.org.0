Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D536382BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 04:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiKYDf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 22:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKYDf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:35:26 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B753C2982C;
        Thu, 24 Nov 2022 19:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f8/x32fER3aRdejEpsCx+wOLDBv/ItD+V8F3NbSrtbc=; b=r01ynWszvCOW0gRReJc0mPmaeT
        4udkpjpGBia+sXIkLIOXBsuaTlBVVkhuppKmpDdjkBhDkp9t+rxXxKEZfC7Fah0vLuWEsX16J14kQ
        iTDi+/xmZDYDDpRiJO3Ln80mvbANCN9dZ1YHac6GOcrRJjA/aE2lJaIL/tDDVCfEUylL4CZlZXZZX
        nbCeFUeaVpnHpD9IQVhtUafE52qEQizDsH/bqXEg2ls1U9f8Vd+QBwZpM706f8WpTgGDI09nTdvx6
        baGfSswMUU47TynqNM8QZmdIAaIBUdKFdNBuvYwagQEw9nbEwfjDKkq/hBZ4WObbqHj0I0Imkq+By
        1qK4U+Ig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oyPTi-006a41-0t;
        Fri, 25 Nov 2022 03:34:14 +0000
Date:   Fri, 25 Nov 2022 03:34:14 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] filelock: move file locking definitions to separate
 header file
Message-ID: <Y4A3tmISFIR7ERfE@ZenIV>
References: <20221120210004.381842-1-jlayton@kernel.org>
 <Y3xHQwM3UiD/SK0K@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3xHQwM3UiD/SK0K@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:51:31AM +0000, Matthew Wilcox wrote:
> On Sun, Nov 20, 2022 at 03:59:57PM -0500, Jeff Layton wrote:
> > Move the file locking definitions to a new header file, and add the
> > appropriate #include directives to the source files that need them. By
> > doing this we trim down fs.h a bit and limit the amount of rebuilding
> > that has to be done when we make changes to the file locking APIs.
> 
> I'm in favour of this in general, but I think there's a few implicit
> includes.  Can you create a test.c that only #include
> <linnux/filelock.h> and see if there's anything missing?
> 
> > +	wait_queue_head_t fl_wait;
> > +	struct file *fl_file;
> 
> These two seem undefined at this point.
> 
> > +	struct fasync_struct *	fl_fasync; /* for lease break notifications */
> 
> Likewise.

#include <linux/wait.h>

struct file;
struct fasync_struct;


