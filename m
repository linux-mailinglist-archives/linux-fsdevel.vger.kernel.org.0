Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1BAA70B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 18:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfICQlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 12:41:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730072AbfICQlI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:41:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 792408553F;
        Tue,  3 Sep 2019 16:41:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D7F419C78;
        Tue,  3 Sep 2019 16:41:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <TYAPR01MB454492E48362BED351E797B2D8B90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <TYAPR01MB454492E48362BED351E797B2D8B90@TYAPR01MB4544.jpnprd01.prod.outlook.com> <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk> <156717348608.2204.16592073177201775472.stgit@warthog.procyon.org.uk>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     dhowells@redhat.com,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "raven@themaw.net" <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/11] Add a general, global device notification watch list [ver #7]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28300.1567528863.1@warthog.procyon.org.uk>
Date:   Tue, 03 Sep 2019 17:41:03 +0100
Message-ID: <28301.1567528863@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 03 Sep 2019 16:41:07 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> wrote:

> It seems to lack modification for arch/arm64.

Fixed.

David
