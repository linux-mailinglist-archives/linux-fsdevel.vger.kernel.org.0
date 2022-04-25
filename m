Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7214050D7B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 05:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbiDYDnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 23:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240801AbiDYDnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D146286E1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Apr 2022 20:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650858029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=90rrxOVsEMID8IC7xlvD6/AwL0J+LK1t9cJRjNj1fGo=;
        b=iFJyDmkfhdjvYnkA3ihu9SJwsx4SibUmO0wY/gBx9vlMFV9KKORIZvvU0oPtpI5PuW4Aub
        CzktyX/rxhflDN34nFColOOm3uwRXhSTBv/RJmOKqbhHwLTRfxvcFuY/idv0qQ42p+lEte
        M/4cnsfly3EUPCJcwJWX12NUy4ZxRLo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-1ZAa2xNsPaOznEgVyThoIw-1; Sun, 24 Apr 2022 23:40:24 -0400
X-MC-Unique: 1ZAa2xNsPaOznEgVyThoIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8904C1C0514D;
        Mon, 25 Apr 2022 03:40:21 +0000 (UTC)
Received: from localhost (ovpn-12-73.pek2.redhat.com [10.72.12.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 809AA409B3E2;
        Mon, 25 Apr 2022 03:40:20 +0000 (UTC)
Date:   Mon, 25 Apr 2022 11:40:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        hch@lst.de, yangtiezhu@loongson.cn, amit.kachhap@arm.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        willy@infradead.org
Subject: Re: [PATCH v5 RESEND 0/3] Convert vmcore to use an iov_iter
Message-ID: <YmYYIeU6qBDpCE4v@MiWiFi-R3L-srv>
References: <20220408090636.560886-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408090636.560886-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

On 04/08/22 at 05:06pm, Baoquan He wrote:
> Copy the description of v3 cover letter from Willy:
> ===
> For some reason several people have been sending bad patches to fix
> compiler warnings in vmcore recently.  Here's how it should be done.
> Compile-tested only on x86.  As noted in the first patch, s390 should
> take this conversion a bit further, but I'm not inclined to do that
> work myself.

Ping!

This patchset has got one ack, can we merge it now?

The lkp reported issue is not related to this patchset, but an existed
one. We can fix it in another patch.

Thanks
Baoquan

