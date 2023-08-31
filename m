Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4CA78EFAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 16:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345247AbjHaOjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 10:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjHaOjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:39:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F2BCD8;
        Thu, 31 Aug 2023 07:39:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 890D967373; Thu, 31 Aug 2023 16:39:47 +0200 (CEST)
Date:   Thu, 31 Aug 2023 16:39:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: sb->s_fs_info freeing fixes
Message-ID: <20230831143947.GA16365@lst.de>
References: <20230831053157.256319-1-hch@lst.de> <20230831-dazulernen-gepflanzt-8a64056bf362@brauner> <20230831-tiefbau-freuden-3e8225acc81d@brauner> <20230831123619.GB11156@lst.de> <20230831-wohlig-lehrveranstaltung-7c27e05dc9ae@brauner> <CAHC9VhQOpy=rLNmirT7afkEdf5_PRnLVsdPJQvxqaF0G4JrCgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQOpy=rLNmirT7afkEdf5_PRnLVsdPJQvxqaF0G4JrCgQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 10:38:09AM -0400, Paul Moore wrote:
> No need to change anything in this case, but in the future if there
> are no patch dependency or ordering issues can you let me take the
> SELinux patches via the SELinux tree?  It helps prevent merge
> conflicts during the next merge window and quiets the daily automated
> checks I have in place to detect SELinux changes outside of the
> SELinux tree.

Even if this goes into the next merge window we'd need it in the vfs
tree as it is preparation for other work on VFS interfaces.
