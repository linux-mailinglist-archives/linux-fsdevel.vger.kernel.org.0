Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B698EB12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 14:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfHOMHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 08:07:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731629AbfHOMHF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:07:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73AD42A09B3;
        Thu, 15 Aug 2019 12:07:05 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 423EE95A42;
        Thu, 15 Aug 2019 12:07:05 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 1596718005A0;
        Thu, 15 Aug 2019 12:07:05 +0000 (UTC)
Date:   Thu, 15 Aug 2019 08:07:04 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Steve Whitehouse <swhiteho@redhat.com>,
        Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        cluster-devel@redhat.com
Message-ID: <1709436723.8673728.1565870824837.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190814204259.120942-4-arnd@arndb.de>
References: <20190814204259.120942-1-arnd@arndb.de> <20190814204259.120942-4-arnd@arndb.de>
Subject: Re: [PATCH v5 03/18] gfs2: add compat_ioctl support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.117.77, 10.4.195.5]
Thread-Topic: gfs2: add compat_ioctl support
Thread-Index: 8SO9yFi8yGVJNB4umFOMffc9nMr6lg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 15 Aug 2019 12:07:05 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Original Message -----
> Out of the four ioctl commands supported on gfs2, only FITRIM
> works in compat mode.
> 
> Add a proper handler based on the ext4 implementation.
> 
> Fixes: 6ddc5c3ddf25 ("gfs2: getlabel support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/gfs2/file.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Hi,

Reviewed-by: Bob Peterson <rpeterso@redhat.com>

Regards,

Bob Peterson
