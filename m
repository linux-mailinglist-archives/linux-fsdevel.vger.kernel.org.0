Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 693A34A32E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 16:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfFROAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 10:00:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfFROAm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:00:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B293308792D;
        Tue, 18 Jun 2019 14:00:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06F427BE64;
        Tue, 18 Jun 2019 14:00:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20190601160822.GA77761@google.com>
References: <20190601160822.GA77761@google.com> <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk> <155905633578.1662.8087594848892366318.stgit@warthog.procyon.org.uk>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 09/25] vfs: Allow mount information to be queried by fsinfo() [ver #13]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18753.1560866343.1@warthog.procyon.org.uk>
From:   David Howells <dhowells@redhat.com>
Date:   Tue, 18 Jun 2019 15:00:30 +0100
Message-ID: <18849.1560866430@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 18 Jun 2019 14:00:42 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Joel Fernandes <joel@joelfernandes.org> wrote:

> > +	record.mnt_id = m->mnt_id;
> > +	record.notify_counter = atomic_read(&m->mnt_notify_counter);
> > +	store_mount_fsinfo(params, &record);
> > +
> > +	rcu_read_unlock();
> 
> Not super familiar with this code, but wanted to check with you:
> 
> Here, if the rcu_read_lock is supposed to protect the RCU list, can
> rcu_read_lock() scope be reduced to just wrapping around the
> list_for_each_entry_rcu?

Done.

David
