Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C07932D5AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 08:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfE2Gpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 02:45:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfE2Gpu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 02:45:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D48EC057E3C;
        Wed, 29 May 2019 06:45:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23DCA5D9E1;
        Wed, 29 May 2019 06:45:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOQ4uxjC1M7jwjd9zSaSa6UW2dbEjc+ZbFSo7j9F1YHAQxQ8LQ@mail.gmail.com>
References: <CAOQ4uxjC1M7jwjd9zSaSa6UW2dbEjc+ZbFSo7j9F1YHAQxQ8LQ@mail.gmail.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Ian Kent <raven@themaw.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC][PATCH 0/7] Mount, FS, Block and Keyrings notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22970.1559112346.1@warthog.procyon.org.uk>
Date:   Wed, 29 May 2019 07:45:46 +0100
Message-ID: <22971.1559112346@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 29 May 2019 06:45:50 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> wrote:

> I am interested to know how you envision filesystem notifications would
> look with this interface.

What sort of events are you thinking of by "filesystem notifications"?  You
mean things like file changes?

David
