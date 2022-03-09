Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBCC4D3229
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 16:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiCIPuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 10:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiCIPun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:50:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD219131122
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 07:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646840983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QxS/WDQr3tUQMEh78l2OAofG/jJPLXvvMADs/iNJnek=;
        b=Y38uGL4YV9PzF7I2iDARJ+CyW0Rw9+kDA3a5Ei6VyxGY7YoxiP95f9aKckOIuXb0+m/TyN
        N8CDEPKU9QMmEv2rccCf3MlM0GXKm1A0wDQU/FQ7KXmJ61a6qXJIduKG31fHa/f0j9OweC
        pvsbdhZnwuhy+EWm7P/3mHG/NMCODHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-fKjxpOpmPaS5naFCbwTcEA-1; Wed, 09 Mar 2022 10:49:42 -0500
X-MC-Unique: fKjxpOpmPaS5naFCbwTcEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6004FC80;
        Wed,  9 Mar 2022 15:49:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C291D804CD;
        Wed,  9 Mar 2022 15:49:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <c2f4b3dc107b106e04c48f54945a12715cccfdf3.camel@redhat.com>
References: <c2f4b3dc107b106e04c48f54945a12715cccfdf3.camel@redhat.com> <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk> <164678192454.1200972.4428834328108580460.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/19] netfs: Generate enums from trace symbol mapping lists
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1712591.1646840957.1@warthog.procyon.org.uk>
Date:   Wed, 09 Mar 2022 15:49:17 +0000
Message-ID: <1712592.1646840957@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> Should you undef EM and E_ here after creating these?

Maybe.  So far it hasn't mattered...

David

