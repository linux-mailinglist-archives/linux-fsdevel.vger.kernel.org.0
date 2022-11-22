Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785D663343B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 04:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiKVDwU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 22:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiKVDwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:52:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AFE2B182;
        Mon, 21 Nov 2022 19:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nf/bUURZpgL7+v01nDvViY+Mr2gn9Uq0Zv4IVJAqBIY=; b=pOnuFxI6xpMtGusD1QKOmUNaiu
        2G5WRi+pfuY2r1ILekGYfv+DmeMOEpo/9ZdfvtpgAw1Y1jnj/LcGblh8MiyfMovp8mLvKNdfUP/qI
        8R/UAAI5nVvaOQ8pSKG/rbuZ0VicxWqV4T1YGGVkt/RUglsV4NUqDoSiw0gmoccxvMxcYQ+10mgyq
        9B34ZIPM7+a/xi7vJHzDVB3NuDEFPfxL2tnCXZYEm1Px1iwHfqivbQNmLDdAhN6o8QmYRAyDENCDX
        RC3YVkPwPWNjGb/sgJLU0O4zrABPqKl4Vd/vL10iTc0IngH+XcCfs+tFpuOER1DxHIoO9jhrM1FLP
        7+QDvHAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxKJn-005uRS-KD; Tue, 22 Nov 2022 03:51:31 +0000
Date:   Tue, 22 Nov 2022 03:51:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <Y3xHQwM3UiD/SK0K@casper.infradead.org>
References: <20221120210004.381842-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120210004.381842-1-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 20, 2022 at 03:59:57PM -0500, Jeff Layton wrote:
> Move the file locking definitions to a new header file, and add the
> appropriate #include directives to the source files that need them. By
> doing this we trim down fs.h a bit and limit the amount of rebuilding
> that has to be done when we make changes to the file locking APIs.

I'm in favour of this in general, but I think there's a few implicit
includes.  Can you create a test.c that only #include
<linnux/filelock.h> and see if there's anything missing?

> +	wait_queue_head_t fl_wait;
> +	struct file *fl_file;

These two seem undefined at this point.

> +	struct fasync_struct *	fl_fasync; /* for lease break notifications */

Likewise.

