Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1E2FC41B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 23:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404862AbhASO3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 09:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387536AbhASJcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:32:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B82C061573;
        Tue, 19 Jan 2021 01:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=taq5tzVqr3iEBWWti4pQj7DR4l
        7cZy9j0PIh3fkDa3n8/8qdyCXkj2WGrt83/vIsHGS5WCm7PvXgo7FyDV1m8MZzbLmVT9xpv0whS28
        jJsZ5vAFO7v/uQfzIP1zm1tq2jPDfBwVjhwKxMCZKDsC40DqWrBlGQsdVXuE0H5mW704POSbSuUJu
        nkobKLxB+vf+pRq6div6jATE4CmZwdKLH34k9aFPepI7kb9k2dfFaq9jX4cbgpxkv6eB4L48vd/Ls
        Lf0Gryfd6h4uwKYvclqPdVOo9DQGZ3Czmr6yXkaJOHwtWWZkkH4Opx+gOP8N1t95nf6VkC4hwu3ji
        8eVK3Xxw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1nLu-00E7PQ-Vs; Tue, 19 Jan 2021 09:31:09 +0000
Date:   Tue, 19 Jan 2021 09:31:06 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        St??phane Graber <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 16/42] xattr: handle idmapped mounts
Message-ID: <20210119093106.GA3364550@infradead.org>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210112220124.837960-17-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112220124.837960-17-christian.brauner@ubuntu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
