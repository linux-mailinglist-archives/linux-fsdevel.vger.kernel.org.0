Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC015D31E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 22:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfJJUWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 16:22:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfJJUWU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:22:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A6E418C8918;
        Thu, 10 Oct 2019 20:22:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C82A196B2;
        Thu, 10 Oct 2019 20:22:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <a0ec09f1-20e0-c0d6-ae90-f088514e7895@gmail.com>
References: <a0ec09f1-20e0-c0d6-ae90-f088514e7895@gmail.com> <157072715575.11228.4215410314199958755.stgit@warthog.procyon.org.uk>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Add manpages for move_mount(2) and open_tree(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27445.1570738938.1@warthog.procyon.org.uk>
Date:   Thu, 10 Oct 2019 21:22:18 +0100
Message-ID: <27446.1570738938@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Thu, 10 Oct 2019 20:22:20 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:

> [MANPAGE] fsopen.2, fsmount.2
> [MANPAGE] fspick.2
> [MANPAGE] fsconfig.2
> [MANPAGE] open_tree.2
> [MANPAGE] move_mount.2

Those were really aimed at non-doccy people to have a look over without
needing to apply the patch or strip the diff metadata.

Roff is hard enough to read as it is ;-)

> [PATCH 1/2] Add manpages for move_mount(2) and open_tree(2)
> [PATCH 2/2] Add manpage for fsopen(2), fspick(2) and fsmount(2)

Those were aimed specifically at you.

If it's okay with you, I'll wait a bit before splitting and resending the
patches, just in case anyone points out any problems.

David
