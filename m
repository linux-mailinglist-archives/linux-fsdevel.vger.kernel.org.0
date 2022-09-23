Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEA35E7390
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 07:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiIWF6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 01:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIWF6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:58:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1809912207B;
        Thu, 22 Sep 2022 22:58:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2241368AFE; Fri, 23 Sep 2022 07:58:27 +0200 (CEST)
Date:   Fri, 23 Sep 2022 07:58:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 00/29] acl: add vfs posix acl api
Message-ID: <20220923055826.GA15662@lst.de>
References: <20220922151728.1557914-1-brauner@kernel.org> <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com> <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com> <16ca7e4c-01df-3585-4334-6be533193ba6@schaufler-ca.com> <CAHC9VhQRST66pVuNM0WGJsh-W01mDD-bX=GpFxCceUJ1FMWrmg@mail.gmail.com> <20220922215731.GA28876@mail.hallyn.com> <CAHC9VhSBwavTLcgkgJ-AYwH9wzECi3B7BtwdKOx5FJ3n7M+WYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSBwavTLcgkgJ-AYwH9wzECi3B7BtwdKOx5FJ3n7M+WYg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:13:44PM -0400, Paul Moore wrote:
> In my opinion, sending the entire patchset to the relevant lists
> should be the default for all the reasons mentioned above.

Agreed.  I'm perfectly fine when people minimize the CCs to actual
people (but then for the entire patch set), but having only the
partial series in an mbox just makes it useful.  Either the list
or person on everything or nothing.  I can't actually do anything
with a partial CC except for either ignoring it or shoting at
you that I need the entire series to do something useful with it.

(although in this case I did get all of it anyway).
