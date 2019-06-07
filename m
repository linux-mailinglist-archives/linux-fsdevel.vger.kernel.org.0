Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA4038F16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 17:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfFGPbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 11:31:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbfFGPbL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:31:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6460C057E37;
        Fri,  7 Jun 2019 15:31:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE9345C70A;
        Fri,  7 Jun 2019 15:30:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <20190607151228.GA1872258@magnolia>
References: <20190607151228.GA1872258@magnolia> <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk> <155991706083.15579.16359443779582362339.stgit@warthog.procyon.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] uapi: General notification ring definitions [ver #4]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27688.1559921390.1@warthog.procyon.org.uk>
From:   David Howells <dhowells@redhat.com>
Date:   Fri, 07 Jun 2019 16:30:51 +0100
Message-ID: <27772.1559921451@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 07 Jun 2019 15:31:11 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I'm starting by reading the uapi changes and the sample program...

If you look in:

  [PATCH 05/13] General notification queue with user mmap()'able ring buffer

you'll find the API document that goes in Documentation/

David
