Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8DA18A2DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 20:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgCRTGe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 15:06:34 -0400
Received: from namei.org ([65.99.196.166]:42074 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRTGd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:06:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02IJ6AgO030251;
        Wed, 18 Mar 2020 19:06:10 GMT
Date:   Thu, 19 Mar 2020 06:06:10 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, christian@brauner.io, andres@anarazel.de,
        jlayton@redhat.com, dray@redhat.com, kzak@redhat.com,
        keyrings@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] selinux: Implement the watch_key security hook
 [ver #5]
In-Reply-To: <158454388633.2863966.17799427202351674141.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.2003190605590.29708@namei.org>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454388633.2863966.17799427202351674141.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 Mar 2020, David Howells wrote:

> Implement the watch_key security hook to make sure that a key grants the
> caller View permission in order to set a watch on a key.
> 
> For the moment, the watch_devices security hook is left unimplemented as
> it's not obvious what the object should be since the queue is global and
> didn't previously exist.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

