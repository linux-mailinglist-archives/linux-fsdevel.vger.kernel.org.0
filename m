Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFDF6642E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 15:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjAJOLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 09:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjAJOLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1A150F42
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 06:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673359778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jW0MXg4kTHInb0VV64RAk02+ZJUEz3vvMCLSfMJ7bo0=;
        b=UQccPgg6ynzrClRFjSHOKBAbPlbA0W/MKSpf2a/zDXKGDEaWnjmkNOw1W+nYsLGY4OjlLL
        gI4TQHVmutEm1+MXuqwU5BJhFcCA0ITBzuxCwkzCXKiu3WZGx7Iww/WJEtUzKl2014tj8n
        aNrA8XqTdmU1+pNoUwHpuXPT74l9W0w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-240AZRvcP4uolfqJg_SXKg-1; Tue, 10 Jan 2023 09:09:35 -0500
X-MC-Unique: 240AZRvcP4uolfqJg_SXKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A1FE380664A;
        Tue, 10 Jan 2023 14:09:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A7A82166B26;
        Tue, 10 Jan 2023 14:09:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <97ce37e2fdcfbed29d9467057f0f870359d88b89.1673173920.git.code@siddh.me>
References: <97ce37e2fdcfbed29d9467057f0f870359d88b89.1673173920.git.code@siddh.me> <cover.1673173920.git.code@siddh.me>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     dhowells@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Biggers <ebiggers@kernel.org>,
        keyrings <keyrings@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] include/linux/watch_queue: Improve documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2121104.1673359772.1@warthog.procyon.org.uk>
Date:   Tue, 10 Jan 2023 14:09:32 +0000
Message-ID: <2121105.1673359772@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Siddh Raman Pant <code@siddh.me> wrote:

> +/**
> + * struct watch_type_filter - Filter on watch type
> + *
> + * @type: Type of watch_notification
> + * @subtype_filter: Bitmask of subtypes to filter on
> + * @info_filter: Filter on watch_notification::info
> + * @info_mask: Mask of relevant bits in info_filter
> + */
>  struct watch_type_filter {
>  	enum watch_notification_type type;
> -	__u32		subtype_filter[1];	/* Bitmask of subtypes to filter on */
> -	__u32		info_filter;		/* Filter on watch_notification::info */
> -	__u32		info_mask;		/* Mask of relevant bits in info_filter */
> +	__u32		subtype_filter[1];
> +	__u32		info_filter;
> +	__u32		info_mask;
>  };

Please don't.

The structure is documented fully here:

	Documentation/core-api/watch_queue.rst

See:

	https://docs.kernel.org/core-api/watch_queue.html#event-filtering

The three column approach is much more readable in the code as it doesn't
separate the descriptions from the things described.  Putting things in
columns has been around for around 6000 years.

David

