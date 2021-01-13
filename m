Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DA02F401D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438157AbhAMAnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 19:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392449AbhAMAeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 19:34:10 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FCAC0617AA;
        Tue, 12 Jan 2021 16:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=I9mSrNXmHFYMPApxgFQbDM45P8v8X64ckBsmGZBNtcc=; b=u46K90hkeHO3rgVFT8nIkAgzOu
        URjQXngiZDy+HRu2wxUeRCxaK99ieki5JPU6LEoLpjhkVt8RQaLmgBoK0NLhGruy0JFl5qwVZ9cPS
        SBniw1n3CBJVYJBUDWfaeMzEtZSYDwOFRVc7C9nhxeLaPFQjoJu2oIJ7p6N9bT8/PtXvBzktQxxnd
        lRIYvTygjTQRLIo9G3UJCdSTY71pssx/RAVQAZanXGgnbufK9U6wyvZ9UVYX99gwEq42DMQDLHimz
        u/83ju95Eitc0mOBWxZ9GyeE9wzkY074t/cE1JnWyD2WdLBsAqlep2idC+WvMkdxzcr/OJOiGlAaG
        4EiP6yjQ==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzU5g-0006Zu-CI; Wed, 13 Jan 2021 00:32:48 +0000
Subject: Re: [PATCH v5 41/42] tests: extend mount_setattr tests
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
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
        =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
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
        Christoph Hellwig <hch@lst.de>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210112220124.837960-42-christian.brauner@ubuntu.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5060dcc4-09a3-0ccc-6080-aab3f6b9caef@infradead.org>
Date:   Tue, 12 Jan 2021 16:32:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210112220124.837960-42-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,


On 1/12/21 2:01 PM, Christian Brauner wrote:
> ---
> /* v2 */
> patch introduced
> 
> /* v3 */
> - Christoph Hellwig <hch@lst.de>, Darrick J. Wong <darrick.wong@oracle.com>:
>   - Port main test-suite to xfstests.
> 
> /* v4 */
> unchanged
> 
> /* v5 */
> base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
> ---
>  .../mount_setattr/mount_setattr_test.c        | 483 ++++++++++++++++++
>  1 file changed, 483 insertions(+)
> 
> diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> index 447b91c05cbd..4e94e566e040 100644
> --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> @@ -108,15 +108,57 @@ struct mount_attr {
>  	__u64 attr_set;
>  	__u64 attr_clr;
>  	__u64 propagation;
> +	__u64 userns_fd;
>  };
>  #endif

...


Does "/**" have any special meaning inside tools/testing/ and the
selftest framework?  (I don't see any other such users.)

If not, can you just use the usual "/*" instead? (multiple locations)


> +/**
> + * Validate that negative fd values are rejected.
> + */
> +TEST_F(mount_setattr_idmapped, invalid_fd_negative)
> +{
...

> +}
> +
> +/**
> + * Validate that excessively large fd values are rejected.
> + */
> +TEST_F(mount_setattr_idmapped, invalid_fd_large)
> +{
...

> +}
> +
> +/**
> + * Validate that closed fd values are rejected.
> + */
> +TEST_F(mount_setattr_idmapped, invalid_fd_closed)
> +{
...

> +	}
> +}
> +
> +/**
> + * Validate that the initial user namespace is rejected.
> + */
> +TEST_F(mount_setattr_idmapped, invalid_fd_initial_userns)
> +{
...

> +/**
> + * Validate that an attached mount in our mount namespace can be idmapped.
> + * (The kernel enforces that the mount's mount namespace and the caller's mount
> + *  namespace match.)
> + */
> +TEST_F(mount_setattr_idmapped, attached_mount_inside_current_mount_namespace)
> +{
> +}
> +
> +/**
> + * Validate that idmapping a mount is rejected if the mount's mount namespace
> + * and our mount namespace don't match.
> + * (The kernel enforces that the mount's mount namespace and the caller's mount
> + *  namespace match.)
> + */
> +TEST_F(mount_setattr_idmapped, attached_mount_outside_current_mount_namespace)
> +{
...

> +}
> +
> +/**
> + * Validate that an attached mount in our mount namespace can be idmapped.
> + */
> +TEST_F(mount_setattr_idmapped, detached_mount_inside_current_mount_namespace)
> +{
...

> +}
> +
> +/**
> + * Validate that a detached mount not in our mount namespace can be idmapped.
> + */
> +TEST_F(mount_setattr_idmapped, detached_mount_outside_current_mount_namespace)
> +{
...

> +}
> +
> +/**
> + * Validate that currently changing the idmapping of an idmapped mount fails.
> + */
> +TEST_F(mount_setattr_idmapped, change_idmapping)
> +{


thanks.
-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
