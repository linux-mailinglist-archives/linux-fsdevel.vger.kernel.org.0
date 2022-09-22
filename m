Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1412D5E6EED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 23:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiIVV5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 17:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiIVV5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:57:36 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9231711264F;
        Thu, 22 Sep 2022 14:57:33 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id DEE18C1D; Thu, 22 Sep 2022 16:57:31 -0500 (CDT)
Date:   Thu, 22 Sep 2022 16:57:31 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 00/29] acl: add vfs posix acl api
Message-ID: <20220922215731.GA28876@mail.hallyn.com>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
 <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com>
 <16ca7e4c-01df-3585-4334-6be533193ba6@schaufler-ca.com>
 <CAHC9VhQRST66pVuNM0WGJsh-W01mDD-bX=GpFxCceUJ1FMWrmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQRST66pVuNM0WGJsh-W01mDD-bX=GpFxCceUJ1FMWrmg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 03:07:44PM -0400, Paul Moore wrote:
> On Thu, Sep 22, 2022 at 2:54 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 9/22/2022 10:57 AM, Linus Torvalds wrote:
> > > On Thu, Sep 22, 2022 at 9:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >> Could we please see the entire patch set on the LSM list?
> > > While I don't think that's necessarily wrong, I would like to point
> > > out that the gitweb interface actually does make it fairly easy to
> > > just see the whole patch-set.
> > >
> > > IOW, that
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/log/?h=fs.acl.rework
> > >
> > > that Christian pointed to is not a horrible way to see it all. Go to
> > > the top-most commit, and it's easy to follow the parent links.
> >
> > I understand that the web interface is fine for browsing the changes.
> > It isn't helpful for making comments on the changes. The discussion
> > on specific patches (e.g. selinux) may have impact on other parts of
> > the system (e.g. integrity) or be relevant elsewhere (e.g. smack). It
> > can be a real problem if the higher level mailing list (the LSM list
> > in this case) isn't included.
> 
> This is probably one of those few cases where Casey and I are in
> perfect agreement.  I'd much rather see the patches hit my inbox than
> have to go hunting for them and then awkwardly replying to them (and
> yes, I know there are ways to do that, I just personally find it
> annoying).  I figure we are all deluged with email on a daily basis
> and have developed mechanisms to deal with that in a sane way, what is
> 29 more patches on the pile?

Even better than the web interface, is find the message-id in any of the
emails you did get, and run

b4 mbox 20220922151728.1557914-1-brauner@kernel.org

In general I'd agree with sending the whole set to the lsm list, but
then one needs to start knowing which lists do and don't want the whole
set...  b4 mbox and lei are now how I read all kernel related lists.

-serge
