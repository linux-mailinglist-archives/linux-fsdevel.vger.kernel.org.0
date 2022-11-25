Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A46638E71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 17:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKYQpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 11:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKYQpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:45:33 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB262BB38;
        Fri, 25 Nov 2022 08:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x53sQaWDa/88sDZr4eyy32ZPwwt0aIb86EtvxNAGN44=; b=FgIlSpJUVdmZH0PghTbL44P7IF
        e4NY5MC1spnQ/Hghs2BPEnAn4l+90NGdQnegTxnvF3OJ+U61eJwM1xO7mu1dExG7v6tzYFJlIwp6P
        B2aUL8HMJfhwXPEFKGEUx8W81rpFniQnI/SO1y7EbgaIaJZ1BUdY5gveE/1N4GNXa8B97uvPu85K6
        Yklhfru9ymFK8ftcM08F8KvpHHcaOQRkbEAd2Tsqc4ddBcwjQEZAIlZg7vNI/YdzW+wA2axEbhN4Z
        espCpyFT59uiQWc205hVxBxnTMNyu5Rhgwc6LnCyra/HjzGVoTTOmo0NKot9JbtDIoan182Jla8Wi
        UlV/To0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oyboR-006i8e-1U;
        Fri, 25 Nov 2022 16:44:27 +0000
Date:   Fri, 25 Nov 2022 16:44:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
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
Message-ID: <Y4Dw65Nzt4bX9esd@ZenIV>
References: <20221120210004.381842-1-jlayton@kernel.org>
 <Y4A6/ozhUncxbimi@ZenIV>
 <1d474f53670771f324745f597ec94b63a006d687.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d474f53670771f324745f597ec94b63a006d687.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 25, 2022 at 08:23:45AM -0500, Jeff Layton wrote:

> I left it in fs.h for now. Some of the file_operations prototypes need
> that typedef, and I figure that anyone who is including filelock.h will
> almost certainly need to include fs.h anyway. We could move it into a
> separate header too, but it's probably not worth it.
> 
> HCH mentioned years ago though that we should just get rid of fl_owner_t
> altogether and just use 'void *'. I didn't do it at the time because I
> was focused on other changes, but this might be a good time to change
> it.

Might be...

> > > +extern void show_fd_locks(struct seq_file *f,
> > > +			 struct file *filp, struct files_struct *files);
> > 
> > If anything, that would be better off as fl_owner_t...  Again, a separate
> > patch.
> 
> I'm not sure what you mean here. This prototype hasn't changed, and is
> only called from procfs.

Take a look at that function and its caller.  The use of 'files' argument there
is (and can be) only as an opaque pointer to be compared to ->fl_owner; at that
point it might be pointing to freed memory, for all we know (and give false
positives if already reused).

TBH, I'd never been able to finish the audit of files_struct pointers passed
into locks subsystem; there definitely are moments when code from fs/locks.c
is dealing with pointers to already freed instances - show_fd_locks() at the
very least.  They are not dereferenced, but beyond that...
