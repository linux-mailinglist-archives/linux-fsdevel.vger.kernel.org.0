Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 679323BB45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 19:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbfFJRrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 13:47:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387643AbfFJRrV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:47:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4CD2356E8;
        Mon, 10 Jun 2019 17:47:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-126.rdu2.redhat.com [10.10.120.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1951E60565;
        Mon, 10 Jun 2019 17:47:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190610111110.72468326@lwn.net>
References: <20190610111110.72468326@lwn.net> <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk> <155991709983.15579.13232123365803197237.stgit@warthog.procyon.org.uk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] keys: Add a notification facility [ver #4]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10631.1560188831.1@warthog.procyon.org.uk>
Date:   Mon, 10 Jun 2019 18:47:11 +0100
Message-ID: <10632.1560188831@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 10 Jun 2019 17:47:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> wrote:

> > 	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01);
> 
> One little nit: it seems that keyctl_watch_key is actually spelled
> keyctl(KEYCTL_WATCH_KEY, ...).

Yeah - but there'll be a wrapper for it in -lkeyutils.  The syscalls I added
in other patches are, technically, referred to syscall(__NR_xxx, ...) at the
moment too.

David
