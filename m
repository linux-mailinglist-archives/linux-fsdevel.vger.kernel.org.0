Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD1B5EFA08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 18:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbiI2QQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 12:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiI2QQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5186FFA7A
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664468194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SK8jnl25GfBurW867juBk8Hvi+Y8sy3LVuiGjVel2EA=;
        b=d9vpZpz8ZyRxzrxTwfNudgdxuElJ8XsdH3GWeh80I/c3EtjzHmj11D6UsK452wEp8VMPaa
        qeoIIujWcR6K6t8qyKRrwj7jybyJXHDPikil0MlsR6WSYS9h9eYFkssJggBffL29ieFocK
        II9CKWWDrKoWTFNIEgdkY720LbenxYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-tWxvPbKKOv-UAw5fd6zNXg-1; Thu, 29 Sep 2022 12:16:32 -0400
X-MC-Unique: tWxvPbKKOv-UAw5fd6zNXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5441868A2E;
        Thu, 29 Sep 2022 16:16:31 +0000 (UTC)
Received: from starship (unknown [10.40.193.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33A50140EBF4;
        Thu, 29 Sep 2022 16:16:30 +0000 (UTC)
Message-ID: <a2825beac032fd6a76838164d4e2753d30305897.camel@redhat.com>
Subject: Re: Commit 'iomap: add support for dma aligned direct-io' causes
 qemu/KVM boot failures
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, qemu-devel@nongnu.org,
        kvm@vger.kernel.org
Date:   Thu, 29 Sep 2022 19:16:29 +0300
In-Reply-To: <YzW+Mz12JT1BXoZA@kbusch-mbp.dhcp.thefacebook.com>
References: <fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com>
         <YzW+Mz12JT1BXoZA@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-09-29 at 09:48 -0600, Keith Busch wrote:
> I am aware, and I've submitted the fix to qemu here:
> 
>   https://lists.nongnu.org/archive/html/qemu-block/2022-09/msg00398.html
> 


Thanks for quick response!

Question is though, isn't this an kernel ABI breakage?

(I myself don't care, I would be happy to patch my qemu), 

but I afraid that this will break *lots* of users that only updated the kernel
and not the qemu.

What do you think?

Best regards,
	Maxim Levitsky

