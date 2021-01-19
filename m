Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5172FB990
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 15:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405556AbhASOdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 09:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388605AbhASJse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:48:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8613C061573;
        Tue, 19 Jan 2021 01:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KBLdqigwXHa9zb4IKHjzXYIBtipeYgH3IvVF9mKe8Wc=; b=rkMudNvWO66HMSQr1C/riYx6VA
        ITPbSZKgiBW4KcAtUmJmkUr1dBGlA/LNN3BGZBcxy4D6iuF9UCTZW8+fvX6Fs2HjXaH7Id164/C6p
        8aX7aQWKUIb43BuHAt825NJDtfHZ03eFtv7j69IJStn2YxsSOCpKR6Ec83TqhIMYX2rT5ua6MVffv
        dkDjTkT8HY7yNCIjlZIOXXuGVjfTfypwT0jzue7d0zu6Oqjhs9YmICue9ulItMg+VcpccEHVuyhvT
        Git07uadZsjuEsjKkGCVR9P2D1ctpz0L0F93Xqf5Qcom70CCTkD4H7p/+v1MyKeAUkCnqLSoSIzQN
        d/kOWGMA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1nc6-00E8cK-3V; Tue, 19 Jan 2021 09:47:50 +0000
Date:   Tue, 19 Jan 2021 09:47:50 +0000
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
        Christoph Hellwig <hch@lst.de>,
        Mauricio V??squez Bernal <mauricio@kinvolk.io>
Subject: Re: [PATCH v5 40/42] fs: introduce MOUNT_ATTR_IDMAP
Message-ID: <20210119094750.GQ3364550@infradead.org>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210112220124.837960-41-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112220124.837960-41-christian.brauner@ubuntu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Generally looks good, but wouldn't it make sense to introduce the
userns_fd in version 0 of the mount_attr structure instead of having
two versions from the start?
