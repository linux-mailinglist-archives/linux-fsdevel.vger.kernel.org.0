Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE8A19AE27
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 16:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbgDAOlM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 10:41:12 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:49886 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgDAOlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:41:12 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 25D0AE814E8;
        Wed,  1 Apr 2020 16:41:10 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 9A065160704; Wed,  1 Apr 2020 16:41:09 +0200 (CEST)
Date:   Wed, 1 Apr 2020 16:41:09 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        dray@redhat.com, kzak@redhat.com, mszeredi@redhat.com,
        swhiteho@redhat.com, jlayton@redhat.com, raven@themaw.net,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cyphar@cyphar.com
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200401144109.GA29945@gardel-login>
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2418286.1585691572@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Di, 31.03.20 22:52, David Howells (dhowells@redhat.com) wrote:

> Christian Brauner <christian.brauner@ubuntu.com> wrote:
>
> > querying all properties of a mount atomically all-at-once,
>
> I don't actually offer that, per se.
>
> Having an atomic all-at-once query for a single mount is actually quite a
> burden on the system.  There's potentially a lot of state involved, much of
> which you don't necessarily need.

Hmm, do it like with statx() and specify a mask for the fields userspace
wants? Then it would be as lightweight as it possibly could be?

Lennart

--
Lennart Poettering, Berlin
