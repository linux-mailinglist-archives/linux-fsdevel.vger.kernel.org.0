Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC4918A2BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 19:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCRS5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 14:57:54 -0400
Received: from namei.org ([65.99.196.166]:42030 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgCRS5y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:57:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02IIvYvj029893;
        Wed, 18 Mar 2020 18:57:34 GMT
Date:   Thu, 19 Mar 2020 05:57:34 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, christian@brauner.io, andres@anarazel.de,
        jlayton@redhat.com, dray@redhat.com, kzak@redhat.com,
        keyrings@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] security: Add a hook for the point of notification
 insertion [ver #5]
In-Reply-To: <158454382138.2863966.4611034029343321389.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.2003190557200.29708@namei.org>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454382138.2863966.4611034029343321389.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 Mar 2020, David Howells wrote:

> Add a security hook that allows an LSM to rule on whether a notification
> message is allowed to be inserted into a particular watch queue.
> 
> The hook is given the following information:
> 
>  (1) The credentials of the triggerer (which may be init_cred for a system
>      notification, eg. a hardware error).
> 
>  (2) The credentials of the whoever set the watch.
> 
>  (3) The notification message.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: Stephen Smalley <sds@tycho.nsa.gov>
> cc: linux-security-module@vger.kernel.org
> ---
> 
>  include/linux/lsm_hooks.h |   14 ++++++++++++++
>  include/linux/security.h  |   14 ++++++++++++++
>  security/security.c       |    9 +++++++++
>  3 files changed, 37 insertions(+)


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

