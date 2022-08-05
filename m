Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B5758B03F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 21:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbiHETRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 15:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240994AbiHETRI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DA1727B0B
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Aug 2022 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659727026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wz2EdOGG/D9qh1RXeFa2rAxeTVlLfTLZN3gXxDqUcbs=;
        b=T85/ccI0l3NhEqTQ8SvMFS9XAT1wasFgOGmNLrEWgR9ZpxS90japcBPLV1qH+pUqn31J/3
        UBeO916n3ktRzVdd5hahc2QFMOaVJA3pSwOXUVxZlgPTdtfgPkYjv9hxekMW9ofJIenOdF
        m4w0EBGmQLOKhtHeWR4GO9ipezBP0oI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-yQ23jwzwMSil63lyILamjQ-1; Fri, 05 Aug 2022 15:17:03 -0400
X-MC-Unique: yQ23jwzwMSil63lyILamjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 075AF3C025CA;
        Fri,  5 Aug 2022 19:17:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2F322166B26;
        Fri,  5 Aug 2022 19:17:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220805183543.274352-2-jlayton@kernel.org>
References: <20220805183543.274352-2-jlayton@kernel.org> <20220805183543.274352-1-jlayton@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        lczerner@redhat.com, bxue@redhat.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>
Subject: Re: [RFC PATCH 1/4] vfs: report change attribute in statx for IS_I_VERSION inodes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3731055.1659727021.1@warthog.procyon.org.uk>
Date:   Fri, 05 Aug 2022 20:17:01 +0100
Message-ID: <3731056.1659727021@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> +	__u64	stx_chgattr;	/* Inode change attribute */

Why not call it stx_change_attr?

David

