Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00D450725B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354178AbiDSQAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 12:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354157AbiDSQAJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 964EF2409E
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650383845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PrrNuS+foM693GJvOCbAI1vgpisQh65cvvQgte9kMSQ=;
        b=bunVV8tOJ5Cd75fmi+fZq0M3RRng9nfQKyQYtgEtY0FILsFSYPO/RZoQTDTVpbhFUctr8Y
        3EzvyYdTBTgXhXgBUIa2eIUOXoCrXH+E1KKGXPwnAGZ+ALPPu/XpMPc4F1YtLPjEstAZyS
        Qi23Eu5G1zRkRh4alJRyBMq1GBWaaRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-IrbSQAUOPmGKYLFhBloLAg-1; Tue, 19 Apr 2022 11:57:23 -0400
X-MC-Unique: IrbSQAUOPmGKYLFhBloLAg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 200DA83397D;
        Tue, 19 Apr 2022 15:56:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6471AC159B3;
        Tue, 19 Apr 2022 15:56:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
References: <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
To:     Max Kellermann <mk@cm4all.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <507517.1650383808.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 19 Apr 2022 16:56:48 +0100
Message-ID: <507518.1650383808@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Max Kellermann <mk@cm4all.com> wrote:

>  -                * For these first content media elements, the `loading=
` attribute will be omitted. By default, this is the case
>  +                * For these first content media elements, the `loading=
` efault, this is the case
>                   * for only the very first content media element.
>                   *
>                   * @since 5.9.0
>  @@ -5377,3 +5377,4 @@
>   =

>          return $content_media_count;
>   }
>  +^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@

This is weird.  It looks like content got slid down by 31 bytes and 31 zer=
o
bytes got added at the end.  I'm not sure how fscache would achieve that -
nfs's implementation should only be dealing with pages.

David

