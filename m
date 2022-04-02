Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018054EFF08
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 07:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352271AbiDBFbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 01:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbiDBFbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 01:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F1C849262
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Apr 2022 22:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648877377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vUfqlNh1E0TZEhR4VZvLOwUGOkstas2fLvtdw5XPc7k=;
        b=C5zZC0xC+58IDEMqyAPK3X9u0S7aTwaxEmF/Vkwy0f7lWuvaVfjcSNW+RURCve1UgHZqel
        7FeX4k/0nGXgfPDRh2G3AVCSu677t+P6hfj5XLcLkazKh2i7xYDWsydMkxTD7QfSFWUq07
        FyCl3SwB/iIXQc4gI8YIVSfPAtoovBY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-k7D2uteqM3Cx5wAvQmgjuw-1; Sat, 02 Apr 2022 01:29:36 -0400
X-MC-Unique: k7D2uteqM3Cx5wAvQmgjuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED16185A5A8;
        Sat,  2 Apr 2022 05:29:35 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0343440885A1;
        Sat,  2 Apr 2022 05:29:34 +0000 (UTC)
Date:   Sat, 2 Apr 2022 13:29:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        yangtiezhu@loongson.cn, amit.kachhap@arm.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 1/3] vmcore: Convert copy_oldmem_page() to take an
 iov_iter
Message-ID: <YkffO7QHuR2vq3gI@MiWiFi-R3L-srv>
References: <20220402043008.458679-1-bhe@redhat.com>
 <20220402043008.458679-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402043008.458679-2-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/02/22 at 12:30pm, Baoquan He wrote:

It's odd. I cann't see the content of patches in this series from my
mailbox and mail client, but I can see them in lore.kernel.org.

https://lore.kernel.org/all/20220402043008.458679-1-bhe@redhat.com/T/#u

