Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C2BA6D93
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 18:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfICQHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 12:07:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29885 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfICQHv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:07:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4006F315C012;
        Tue,  3 Sep 2019 16:07:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4936B60610;
        Tue,  3 Sep 2019 16:07:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190903125129.GA18838@roeck-us.net>
References: <20190903125129.GA18838@roeck-us.net> <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk> <156717350329.2204.7056537095039252263.stgit@warthog.procyon.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] usb: Add USB subsystem notifications [ver #7]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7480.1567526867.1@warthog.procyon.org.uk>
Date:   Tue, 03 Sep 2019 17:07:47 +0100
Message-ID: <7481.1567526867@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 03 Sep 2019 16:07:51 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> wrote:

> This added call to usbdev_remove() results in a crash when running
> the qemu "tosa" emulation. Removing the call fixes the problem.

Yeah - I'm going to drop the bus notification messages for now.

David
