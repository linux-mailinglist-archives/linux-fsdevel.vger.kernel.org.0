Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BE94C61BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 04:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiB1DSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 22:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiB1DSy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:18:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FD162C112
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 19:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646018295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tsK1Z3+qXd93E96nRxU++sPLj//cbKWzacSgGyJ7zpM=;
        b=Xeu9A0XUa4bAGmLi9OOMvlD/ujMrMcgzicTiC2k7msQ6Q4jTvHtTR34A/aJ43NnKtcBKUh
        WGeAYf0UB6csBgq7e5bbJ51BVXY175SRAUUvxonHAhk0LGOfzwOa2uuRDLljMNFIVzE78V
        +X8HUsoqSAXq3BxNz24yXozeElGFrfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-qEHiR05PMleXfKIwtPEqVg-1; Sun, 27 Feb 2022 22:18:11 -0500
X-MC-Unique: qEHiR05PMleXfKIwtPEqVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85B45824FA6;
        Mon, 28 Feb 2022 03:18:09 +0000 (UTC)
Received: from localhost (ovpn-13-26.pek2.redhat.com [10.72.13.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E039A56F78;
        Mon, 28 Feb 2022 03:18:04 +0000 (UTC)
Date:   Mon, 28 Feb 2022 11:18:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        yingelin <yingelin@huawei.com>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zengweilin@huawei.com,
        chenjianguo3@huawei.com, nixiaoming@huawei.com,
        qiuguorui1@huawei.com, young.liuyang@huawei.com
Subject: Re: [PATCH sysctl-next] kernel/kexec_core: move kexec_core sysctls
 into its own file
Message-ID: <20220228031801.GB150756@MiWiFi-R3L-srv>
References: <20220223030318.213093-1-yingelin@huawei.com>
 <YhXwkTCwt3a4Dn9T@MiWiFi-R3L-srv>
 <c60419f8-422b-660d-8254-291182a06cbe@huawei.com>
 <Yhbu6UxoYXFtDyFk@fedora>
 <YhqLnIjopfoBEBcV@bombadil.infradead.org>
 <b07af605-ab74-a313-f8e4-da794dcde111@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b07af605-ab74-a313-f8e4-da794dcde111@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/28/22 at 09:43am, yingelin wrote:
> 
> 在 2022/2/27 4:20, Luis Chamberlain 写道:
> > On Thu, Feb 24, 2022 at 10:35:21AM +0800, Baoquan He wrote:
> > > That seems to be an issue everything related to sysctl are all added to
> > > kernel/sysctl.c. Do you have a pointer that someone complained about it
> > > and people agree to scatter them into their own component code?
> > https://lkml.kernel.org/r/20220226031054.47DF8C340E7@smtp.kernel.org
> > 
> > > I understand your concern now, I am personally not confused by that
> > > maybe because I haven't got stuff adding or changing into sysctls. My
> > > concern is if we only care and move kexec knob, or we have plan to try
> > > to move all of them. If there's some background information or
> > > discussion with a link, that would be helpful.
> > We're moving them all out. Sorry, yingelin's commit log message sucks
> > and it needs to be fixed to account for the justification. All the
> > filesystem sysctls are already moved out. Slowly we are moving the other
> > ones out and also doing minor optimizations along the way.

Thanks for the explanation. Yeah, not like code chaging for fixing or
improvement, providing justification is very helpful and imporant for
this kind of code moving.


> I'm sorry I didn't express it clearly. I'll fix it in v2 patch.

That's OK, look forward to seeing the v2.

