Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E426069687B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 16:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjBNPu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 10:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjBNPuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:50:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68835AE
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 07:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676389776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9N7LtIUCs1c3MxbwmYpiSal++u4MCEt1aDdzCRdbS6c=;
        b=imKFnwWLugFkedn6ORr36dmq7mofiDKlwK9/7QY1pcajk+BQzq7U8qqM7iMUpmud2Zq84e
        6yH4zklOquUzeNuH9P1ux5boPaoKa2iPtNJ3f2aOBLJWLrltO9/4WOpHYxwRthCYevw4x2
        xqZdcQJBv/+rMm4syp45I/JtkbQzm8A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-Qze0Dd2KNe6BqSZdcFdeGg-1; Tue, 14 Feb 2023 10:49:33 -0500
X-MC-Unique: Qze0Dd2KNe6BqSZdcFdeGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E85C3C0E204;
        Tue, 14 Feb 2023 15:49:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E76B140EBF6;
        Tue, 14 Feb 2023 15:49:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <9dd98aed-0d9a-eb3e-790c-0dd744be8ccb@kernel.dk>
References: <9dd98aed-0d9a-eb3e-790c-0dd744be8ccb@kernel.dk> <20230214083710.2547248-1-dhowells@redhat.com> <75d74adc-7f18-d0df-e092-10bca4f05f2a@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dhowells@redhat.com, David Hildenbrand <david@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 0/5] iov_iter: Adjust styling/location of new splice functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2677037.1676389769.1@warthog.procyon.org.uk>
Date:   Tue, 14 Feb 2023 15:49:29 +0000
Message-ID: <2677038.1676389769@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> wrote:

> That is indeed the question, and unanswered so far... Let's turn it into
> one clean series, and get it stuffed into for-next and most likely
> target 6.4 for inclusion at this point.

I was waiting to see if the patch worked for Daniel (which it does) and
Guenter (no answer yet) before answering.  It appears to fix shmem - I've
tested it with:

	dd if=/dev/zero of=/tmp/sparse count=1 seek=401 bs=4096
	just-splice /tmp/sparse 11234000 | sha1sum

where just-splice.c is attached (note that piping the output into another
program is important to make the splice work).

Meanwhile, I'm working on working the changes into my patchset at appropriate
points.

David
---
#define _GNU_SOURCE 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/sendfile.h>
#include <sys/wait.h>

static char *prog;

int main(int argc, char *argv[])
{
        unsigned int iflags = 0;
        ssize_t spliced, remain;
        int in, out;

        prog = argv[0];
        if (argc > 1 && strcmp(argv[1], "-d") == 0) {
                iflags |= O_DIRECT;
                argv++;
                argc--;
        }

        if (argc != 3 || !argv[1][0] || !argv[2][0]) {
                fprintf(stderr, "Usage: %s <file> <amount>\n", prog);
                exit(2);
        }

        in = open(argv[1], O_RDONLY | O_NOFOLLOW | iflags);
        if (in < 0) {
                perror("open");
                exit(1);
        }

        remain = strtoul(argv[2], NULL, 0);
        while (remain > 0) {
                spliced = splice(in, NULL, 1, NULL, remain, 0);
                if (spliced < 0) {
                        perror("splice");
                        exit(1);
                }
                if (spliced == 0)
                        break;
                remain -= spliced;
        }

        exit(0);
}

