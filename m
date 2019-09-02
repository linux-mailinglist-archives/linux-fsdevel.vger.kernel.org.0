Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40124A565A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfIBMjh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 2 Sep 2019 08:39:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729658AbfIBMjh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:39:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E42313082B40;
        Mon,  2 Sep 2019 12:39:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E669F5D9CC;
        Mon,  2 Sep 2019 12:39:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <563ae8b4-753a-179d-4f6d-94d2dd058f3b@schaufler-ca.com>
References: <563ae8b4-753a-179d-4f6d-94d2dd058f3b@schaufler-ca.com> <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Keyrings, Block and USB notifications [ver #7]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20963.1567427973.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 02 Sep 2019 13:39:33 +0100
Message-ID: <20964.1567427973@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 02 Sep 2019 12:39:37 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> > Tests for the key/keyring events can be found on the keyutils next branch:
> >
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/log/?h=next
> 
> I'm having trouble with the "make install" on Fedora. Is there an
> unusual dependency?

What's the symptom you're seeing?  Is it this:

install -D -m 0644 libkeyutils.a /tmp/opt/lib64 libcrypt.so.2 => /lib64/libcrypt.so.2 (0x00007f7dcbf6d000)/libkeyutils.a
/bin/sh: -c: line 0: syntax error near unexpected token `('
/bin/sh: -c: line 0: `install -D -m 0644 libkeyutils.a /tmp/opt/lib64 libcrypt.so.2 => /lib64/libcrypt.so.2 (0x00007f7dcbf6d000)/libkeyutils.a'

David
