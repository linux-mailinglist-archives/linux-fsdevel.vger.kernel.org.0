Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DF37AB2A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 15:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjIVN0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 09:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjIVN0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E2D196
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695389148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZOSEgdaNayKQCj0Rd2l3QVa88rL7jTEBUClTXsv6/B0=;
        b=BWRou+TM+qAFYeQTw3x47FjAc0eJf+yVTk/7T0S8E3SnXBxOrz/q+28p+DIfUy2TNl9t6v
        aKrEAmEKUXEzsL5szLunMttsD2cO7OBpyEOAXlxiGK62SBZNB3tSv+ap1s9N6NT/PEkFfb
        t4wauJ7fC7AKoCFTpT0ahUmJHbdFwf4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-9sys_9eAOPG9_9wgXY1GrQ-1; Fri, 22 Sep 2023 09:25:42 -0400
X-MC-Unique: 9sys_9eAOPG9_9wgXY1GrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F172C3C0D1B5;
        Fri, 22 Sep 2023 13:25:41 +0000 (UTC)
Received: from redhat.com (unknown [10.22.18.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECC53C15BB8;
        Fri, 22 Sep 2023 13:25:40 +0000 (UTC)
Date:   Fri, 22 Sep 2023 08:25:39 -0500
From:   Bill O'Donnell <bodonnel@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/8] autofs - convert to to use mount api
Message-ID: <ZQ2V0wa6Hia9xbWS@redhat.com>
References: <20230922041215.13675-1-raven@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922041215.13675-1-raven@themaw.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 22, 2023 at 12:12:07PM +0800, Ian Kent wrote:
> There was a patch from David Howells to convert autofs to use the mount
> api but it was never merged.
> 
> I have taken David's patch and refactored it to make the change easier
> to review in the hope of having it merged.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>

for the series...
Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>


> 
> Ian Kent (8):
>   autofs: refactor autofs_prepare_pipe()
>   autofs: add autofs_parse_fd()
>   autofs: refactor super block info init
>   autofs: reformat 0pt enum declaration
>   autofs: refactor parse_options()
>   autofs: validate protocol version
>   autofs: convert autofs to use the new mount api
>   autofs: fix protocol sub version setting
> 
>  fs/autofs/autofs_i.h |  15 +-
>  fs/autofs/init.c     |   9 +-
>  fs/autofs/inode.c    | 423 +++++++++++++++++++++++++------------------
>  3 files changed, 266 insertions(+), 181 deletions(-)
> 
> -- 
> 2.41.0
> 

