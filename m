Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3133538D89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 11:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245104AbiEaJNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 05:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245095AbiEaJNg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 05:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04FEF8A071
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653988415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2jlUopi4YBm49oTnK+gs+DTUpSL7wCA5tJxPfgHvoDA=;
        b=V4AApn15VwzvkAJf3G5PTFowytn+qFFd0NmR6bF0KL1DYBTrfSXj8mG9qhSt+WVnHljBLL
        h4U8UUSBLQlGdcxLHh+8fh740W3YApkaqLj/LRPoYdpCobmsMNY8If+9gJ2t4fMYDgkxbJ
        FkODoFJ5zKVtkknjoo2bnJwn3pV+oSI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-4WBjroF3OJuCd2WhFKekYQ-1; Tue, 31 May 2022 05:13:27 -0400
X-MC-Unique: 4WBjroF3OJuCd2WhFKekYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BECE85A5BC;
        Tue, 31 May 2022 09:13:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4B3FC27E98;
        Tue, 31 May 2022 09:13:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YpXUrclhwN+oOlfj@rabbit.intern.cm-ag>
References: <YpXUrclhwN+oOlfj@rabbit.intern.cm-ag> <YnI7lgazkdi6jcve@rabbit.intern.cm-ag> <Yl75D02pXj71kQBx@rabbit.intern.cm-ag> <Yl7d++G25sNXIR+p@rabbit.intern.cm-ag> <YlWWbpW5Foynjllo@rabbit.intern.cm-ag> <507518.1650383808@warthog.procyon.org.uk> <509961.1650386569@warthog.procyon.org.uk> <705278.1650462934@warthog.procyon.org.uk> <263652.1653986121@warthog.procyon.org.uk>
To:     Max Kellermann <mk@cm4all.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <325230.1653988405.1@warthog.procyon.org.uk>
Date:   Tue, 31 May 2022 10:13:25 +0100
Message-ID: <325231.1653988405@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Max Kellermann <mk@cm4all.com> wrote:

> > Can I put that down as a Tested-by?
> 
> Yes.  A month later, still no new corruption.

Thanks!

David

