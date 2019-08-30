Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7E6A3928
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 16:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfH3OXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 10:23:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfH3OXp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:23:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 390697BDB6;
        Fri, 30 Aug 2019 14:23:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 871F71001925;
        Fri, 30 Aug 2019 14:23:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <21eb33e8-5624-0124-8690-bbea41a1b589@tycho.nsa.gov>
References: <21eb33e8-5624-0124-8690-bbea41a1b589@tycho.nsa.gov> <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk> <156717352079.2204.16378075382991665807.stgit@warthog.procyon.org.uk>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] selinux: Implement the watch_key security hook [ver #7]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5366.1567175021.1@warthog.procyon.org.uk>
Date:   Fri, 30 Aug 2019 15:23:41 +0100
Message-ID: <5368.1567175021@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 30 Aug 2019 14:23:45 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > +	u32 sid = cred_sid(current_cred());
> 
> How does this differ from current_sid()?
> 
> And has current_sid() not been converted to use selinux_cred()? Looks like
> selinux_kernfs_init_security() also uses current_security() directly.

It probably doesn't - okay I'll use that instead.

David
