Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B58633429
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 04:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiKVDpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 22:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiKVDpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:45:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A71529371;
        Mon, 21 Nov 2022 19:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uiFDQ6s5XgAcT9HYz21ROzPo6ZCyN/YsiViP9JuL2Vc=; b=NJJwrm6IpzOJ+nUmhrd1OXfoCk
        G7FtSuALDx10w2NwiIqoKiG9ykgmyUGgqgtM+aJpa2oS2fQRQ+RCGSFLUVL1nV3H67iQsoM+ZXI+P
        75G75qOGTBUz2j3XL00qgcUTJotjzi0OfiKIf+ALXzMf3ZoQMf3KRnGWl+fsNnIUD5GBw7fYM0qpK
        68xmJhc99PpF71YEvdwSpdkfVDQQinCYdj6BfJplncqBsPQyicO+REFgABedNNQo6QpK9GD/KJOMG
        I2YH4RdEbuSk9AKSGChXb1wwhkouk4nfTA4WUiJD8aJEXUyng2vGvKiEnZPT7EPwwj7AX43JZiVeT
        eCgYCCfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxKCp-005u2i-VP; Tue, 22 Nov 2022 03:44:20 +0000
Date:   Tue, 22 Nov 2022 03:44:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <Y3xFkyZykWp5/Rvq@casper.infradead.org>
References: <20221120210004.381842-1-jlayton@kernel.org>
 <6627384e-5514-048f-308e-57414d0c5b31@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6627384e-5514-048f-308e-57414d0c5b31@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 09:26:16AM +0800, Xiubo Li wrote:
[1300+ lines snipped]
> LGTM.
> 
> Reviewed-by: Xiubo Li <xiubli@redhat.com>

You really don't need to quote the whole thing.  Please be more
considerate.
