Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC92DB85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 13:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfE2LQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 07:16:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfE2LQa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 07:16:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C786300CA98;
        Wed, 29 May 2019 11:16:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D7B55D756;
        Wed, 29 May 2019 11:16:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez2SAKbPeChAf06GMazMPPThFM+OR00abRZafAP7v+ptKw@mail.gmail.com>
References: <CAG48ez2SAKbPeChAf06GMazMPPThFM+OR00abRZafAP7v+ptKw@mail.gmail.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk> <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com> <10418.1559084686@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        raven@themaw.net, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15838.1559128587.1@warthog.procyon.org.uk>
Date:   Wed, 29 May 2019 12:16:27 +0100
Message-ID: <15839.1559128587@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 29 May 2019 11:16:30 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> I don't really know. I guess it depends on how it's being used? If
> someone decides to e.g. make a file browser that installs watches for
> a bunch of mountpoints for some fancy sidebar showing the device
> mounts on the system, or something like that, that probably shouldn't
> inhibit unmounting... I don't know if that's a realistic use case.

In such a use case, I would envision the browser putting a watch on "/".  A
watch sees all events in the subtree rooted at that point and you must apply a
filter that filters them out if you're not interested (filter on
WATCH_INFO_IN_SUBTREE using info_filter and info_mask).

David
