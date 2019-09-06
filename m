Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3D2AB4C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 11:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404113AbfIFJRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 05:17:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbfIFJRq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:17:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7D774E924
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2019 09:17:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19FB15D9D3;
        Fri,  6 Sep 2019 09:17:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <7020be46-f21f-bd05-71a5-cb2bc073596b@redhat.com>
References: <7020be46-f21f-bd05-71a5-cb2bc073596b@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     dhowells@redhat.com, fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: fs_parser: remove fs_parameter_description name field
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29445.1567761462.1@warthog.procyon.org.uk>
Date:   Fri, 06 Sep 2019 10:17:42 +0100
Message-ID: <29446.1567761462@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 06 Sep 2019 09:17:46 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Sandeen <sandeen@redhat.com> wrote:

> There doesn't seem to be a strong reason to have another copy of the
> filesystem name string in the fs_parameter_description structure;
> it's easy enough to get the name from the fs_type, and using it
> instead ensures consistency across messages (for example,
> vfs_parse_fs_param() already uses fc->fs_type->name for the error
> messages, because it doesn't have the fs_parameter_description).
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

It was put there for fs_validate_description() to use.  That checks both
filesystem and LSM parameter descriptions.

We could pass a name in to that function instead.

David
