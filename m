Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D6C3751F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfFFNYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 09:24:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfFFNYf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:24:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 627F130F1BAE;
        Thu,  6 Jun 2019 13:24:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A6DD58CB4;
        Thu,  6 Jun 2019 13:24:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <399587cf-9983-8e4f-98ca-6d3e0c9a0103@redhat.com>
References: <399587cf-9983-8e4f-98ca-6d3e0c9a0103@redhat.com> <20190606104618.28321-2-hdegoede@redhat.com> <20190606104618.28321-1-hdegoede@redhat.com> <27351.1559821872@warthog.procyon.org.uk>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v11] fs: Add VirtualBox guest shared folder (vboxsf) support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4333.1559827471.1@warthog.procyon.org.uk>
Date:   Thu, 06 Jun 2019 14:24:31 +0100
Message-ID: <4334.1559827471@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 06 Jun 2019 13:24:35 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> >
> > 		opts->fs_uid = make_kuid(current_user_ns(), option);
> > 		if (!uid_valid(opts->fs_uid))
> > 			return -EINVAL;
> >
> > sort of thing (excerpt from fs/fat/inode.c).
> 
> Shouldn't this use the user-namespace from the filesystem-context?

No.  The uid you're given is with regard to the calling process's namespace,
not the filesystem's.

David
