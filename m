Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B216B5EF0AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 10:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiI2Ihe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 04:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiI2Ihd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24338128706
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 01:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664440651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k/puTgDETOF5JGp7Vf2KBclBynoWE71jHZx9sMGhC/A=;
        b=O3wdlfUR5kxvrvvxiJ3Q58VMRO1X0nt4yrEdNxrAZY8DRfNrPM/SivErxXN7bQN+FCmH3h
        9ANYGbOp9fuO6AcuCenIjbV3T/Ci5VzGKkKfs6WKcXZ06CMfTU2UVdBtwTN9iY59VbQPD5
        PVZ1DN0lRrhZ9240UcFU8Zz0eLOaplI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-vVo5hSePM-eeFhehXWKVoA-1; Thu, 29 Sep 2022 04:37:27 -0400
X-MC-Unique: vVo5hSePM-eeFhehXWKVoA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9371E293248E;
        Thu, 29 Sep 2022 08:37:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F797C15BA8;
        Thu, 29 Sep 2022 08:37:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220922084442.2401223-1-mszeredi@redhat.com>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v4 00/10] fuse tmpfile
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3515860.1664440644.1@warthog.procyon.org.uk>
Date:   Thu, 29 Sep 2022 09:37:24 +0100
Message-ID: <3515861.1664440644@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can you put a description in your cover letter to say what change the patchset
is making to the kernel?

David

