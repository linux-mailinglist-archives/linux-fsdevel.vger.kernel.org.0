Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E371FA821D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 14:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfIDMJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 08:09:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfIDMJD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:09:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13C2185542;
        Wed,  4 Sep 2019 12:09:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9D2F5C219;
        Wed,  4 Sep 2019 12:08:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <23d61564-026e-b37a-8b16-ce68d5949f6c@schaufler-ca.com>
References: <23d61564-026e-b37a-8b16-ce68d5949f6c@schaufler-ca.com> <87bf0363-af77-1e5a-961f-72730e39e3a6@schaufler-ca.com> <e36fa722-a300-2abf-ae9c-a0246fc66d0e@schaufler-ca.com> <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk> <156717352917.2204.17206219813087348132.stgit@warthog.procyon.org.uk> <4910.1567525310@warthog.procyon.org.uk> <11467.1567534014@warthog.procyon.org.uk>
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
Subject: Re: [PATCH 11/11] smack: Implement the watch_key and post_notification hooks [untested] [ver #7]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31204.1567598939.1@warthog.procyon.org.uk>
Date:   Wed, 04 Sep 2019 13:08:59 +0100
Message-ID: <31205.1567598939@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 04 Sep 2019 12:09:03 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> I rebuilt with keys-next, updated the tests again, and now
> the suite looks to be running trouble free.

Can I put you down as an Acked-by or something on this patch?

Thanks,
David
