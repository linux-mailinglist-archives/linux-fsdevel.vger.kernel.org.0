Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCE5633B01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 12:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiKVLQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 06:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiKVLQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:16:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D58B5C771;
        Tue, 22 Nov 2022 03:14:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA3F8B81991;
        Tue, 22 Nov 2022 11:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99661C433C1;
        Tue, 22 Nov 2022 11:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669115639;
        bh=bl116Cg89IGIZVG9NrRKWmlP6ed4aJACzNI0Wp3w7MQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PW904WXq7B5dnjaE/n6/stkLttLw66q95uzaVXXfC57Gr8fGyA50W/Y+6YMHj6/Z6
         C+bp2zR/HpD7AL2kDXCaUnJHLo0QYTjCM7B7srSBYzv9QSoZunuSXqgWz/eURLlX6f
         bkLmFZpbKLyi6RqKREvtIsB+vKfLjAYsE4lMeS50ONpsJGmxbLEBM8TI6eOVtcA0LK
         FmF5vJc1DjzHEZ764Fk6lm5yRoCPsh46VllB8mEkIzIHUVtq1E/Ip3Df/1o0TdNO5Q
         AIsD9dU2QJjYYPKYl3/NasVd/l9SRjkJBU0cAIKGCY06yaw8kwOzVXEKArpk5buENB
         HvI5i9aGVVUAA==
Message-ID: <fcc7161712a2c8ff84420477b12b9114195e6624.camel@kernel.org>
Subject: Re: [PATCH] filelock: move file locking definitions to separate
 header file
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
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
Date:   Tue, 22 Nov 2022 06:13:54 -0500
In-Reply-To: <Y3xHQwM3UiD/SK0K@casper.infradead.org>
References: <20221120210004.381842-1-jlayton@kernel.org>
         <Y3xHQwM3UiD/SK0K@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-11-22 at 03:51 +0000, Matthew Wilcox wrote:
> On Sun, Nov 20, 2022 at 03:59:57PM -0500, Jeff Layton wrote:
> > Move the file locking definitions to a new header file, and add the
> > appropriate #include directives to the source files that need them. By
> > doing this we trim down fs.h a bit and limit the amount of rebuilding
> > that has to be done when we make changes to the file locking APIs.
>=20
> I'm in favour of this in general, but I think there's a few implicit
> includes.  Can you create a test.c that only #include
> <linnux/filelock.h> and see if there's anything missing?
>=20
> > +	wait_queue_head_t fl_wait;
> > +	struct file *fl_file;
>=20
> These two seem undefined at this point.
>=20
> > +	struct fasync_struct *	fl_fasync; /* for lease break notifications */
>=20
> Likewise.
>=20

Yeah, there is quite a bit missing. I think I'll have to add this at the
head of filelock.h:

#include <linux/fs.h>

...as we need several definitions from fs.h for this header.
--=20
Jeff Layton <jlayton@kernel.org>
