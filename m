Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900966658AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 11:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjAKKMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 05:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbjAKKLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:11:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05228B4B1;
        Wed, 11 Jan 2023 02:09:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9990F61BD1;
        Wed, 11 Jan 2023 10:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD77C433F0;
        Wed, 11 Jan 2023 10:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673431768;
        bh=vTG8tkGkgzpoXSI2/xLzI6Hvg87vZDKZ00P9yxoHI64=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KgIY9bOYwJCyOfCiW7o6nNIrn2iWWQQ5tXwTIwDD6HKYH/4GbiuaYsi5USHAueqfF
         qW+c9QphwXJnJEBBSkeZ3QzZ2qjL78DX6brtpjE96UlFGKckD3CshL11vT4uRRIWHz
         uUGbPHoGrJNEMH9NM6lzSSC+MCcnGvoWlKzsj1YG1ecUDwUwqKkPrgm4FQQGLXhuZ6
         tP2riGZnuacry7vNSFPRIhTvYGOxr/NRJY22iA4K0Dv3RFfUbw19rHig2ttj+ZUO0x
         2LDUVW+peqK8CV6IqOT/qJhTun4pq3CFSD/d/wg4wfgC4RYw29uJqQkwH1RoioVK2c
         R6J71KCrpkAKg==
Message-ID: <b93df374c14a0841823da7d5fadd96a0077762c6.camel@kernel.org>
Subject: Re: [PATCH v2] filelock: move file locking definitions to separate
 header file
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Russell King <linux@armlinux.org.uk>,
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
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Steve French <stfrench@microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org
Date:   Wed, 11 Jan 2023 05:09:22 -0500
In-Reply-To: <Y74bDlSiEb2dRFSx@ZenIV>
References: <20230105211937.1572384-1-jlayton@kernel.org>
         <Y74bDlSiEb2dRFSx@ZenIV>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-01-11 at 02:12 +0000, Al Viro wrote:
> On Thu, Jan 05, 2023 at 04:19:29PM -0500, Jeff Layton wrote:
> > The file locking definitions have lived in fs.h since the dawn of time,
> > but they are only used by a small subset of the source files that
> > include it.
> >=20
> > Move the file locking definitions to a new header file, and add the
> > appropriate #include directives to the source files that need them. By
> > doing this we trim down fs.h a bit and limit the amount of rebuilding
> > that has to be done when we make changes to the file locking APIs.
> >=20
> > Reviewed-by: Xiubo Li <xiubli@redhat.com>
> > Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: David Howells <dhowells@redhat.com>
> > Acked-by: Chuck Lever <chuck.lever@oracle.com>
> > Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> > Acked-by: Steve French <stfrench@microsoft.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Same question re git tree preferences (and my Acked-by in any case)

I'll take this one via the file locking tree as well. FWIW, I have some
other filelock API changes I'd like to propose, so I think that'll be
easier.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
