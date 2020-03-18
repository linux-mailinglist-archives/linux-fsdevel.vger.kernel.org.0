Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 302F618A2D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 20:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCRTE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 15:04:27 -0400
Received: from namei.org ([65.99.196.166]:42052 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRTE1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:04:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02IJ47Ki030160;
        Wed, 18 Mar 2020 19:04:07 GMT
Date:   Thu, 19 Mar 2020 06:04:07 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io,
        andres@anarazel.de, jlayton@redhat.com, dray@redhat.com,
        kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] watch_queue: Add a key/keyring notification facility
 [ver #5]
In-Reply-To: <158454384808.2863966.9318850402218181933.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.2003190558240.29708@namei.org>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454384808.2863966.9318850402218181933.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 Mar 2020, David Howells wrote:

> +++ b/Documentation/security/keys/core.rst
> @@ -833,6 +833,7 @@ The keyctl syscall functions are:
>       A process must have search permission on the key for this function to be
>       successful.
>  
> +
>    *  Compute a Diffie-Hellman shared secret or public key::
>  
>  	long keyctl(KEYCTL_DH_COMPUTE, struct keyctl_dh_params *params,

Extraneous newline.


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

