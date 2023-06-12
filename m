Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5AF72C4A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 14:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjFLMnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 08:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjFLMnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DF8AA
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 05:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686573753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ulHVPL3pXPIo5RmxEBnndl9GfORZdMhAtvNQZYsRb4=;
        b=WmjMeOJKMHh1OTvcwOqTXBu2/ualUoHfz/11pTd609oDeKNona/kwssYZWhjb9pyJMzsQN
        xTBBlnYMThu/81tzWzkHMNi9hZGI5Xr742Xk7mejBb+ieuMjotKZo8JHXPdo++xyBFXYdJ
        2jaIebbjaOdxi2XBkWCBZoSfZ/phUiQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-0Iji5oMiMg2ltILwVs-T_Q-1; Mon, 12 Jun 2023 08:42:28 -0400
X-MC-Unique: 0Iji5oMiMg2ltILwVs-T_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EBD21019CA2;
        Mon, 12 Jun 2023 12:42:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9059F40D1B60;
        Mon, 12 Jun 2023 12:42:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <202306120931.a9606b88-oliver.sang@intel.com>
References: <202306120931.a9606b88-oliver.sang@intel.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     dhowells@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [axboe-block:for-6.5/block] [block] 1ccf164ec8: WARNING:at_mm/gup.c:#try_get_folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <108490.1686573741.1@warthog.procyon.org.uk>
Date:   Mon, 12 Jun 2023 13:42:21 +0100
Message-ID: <108491.1686573741@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The attached test reproduces the problem on a loop-back mounted file
containing a UDF filesystem.  The key appears to be the consecutive DIOs to
the same page.

David
---
#define __USE_GNU
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <err.h>
# define O_DIRECT      040000

static char buf[256 * 1024] __attribute__((aligned(512)));
static char *filename;

static void cleanup(void)
{
	if (unlink(filename) == -1)
		err(1, "unlink");
}

int main(int argc, char **argv)
{
	size_t page = 4096;
	int fd;

	if (argc != 2) {
		fprintf(stderr, "Format: %s <file>\n", argv[1]);
		exit(2);
	}

	filename = argv[1];

	fd = open(filename, O_RDWR | O_CREAT | O_EXCL | O_DIRECT, 0666);
	if (fd == -1)
		err(1, "%s", filename);

	atexit(cleanup);

	if (pwrite(fd, buf, page, 0) != page)
		err(1, "pwrite/1");

	if (pwrite(fd, buf, page, page) != page)
		err(1, "pwrite/2");

	if (close(fd) == -1)
		err(1, "close");

	return 0;
}

