Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAD0542590
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbiFHDGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 23:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382741AbiFHDFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A992B1CC5EF
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 17:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654648320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5n7RskVKP1lkUAH2EjF8RedQEXHRrdfvn+kcEQHl4g=;
        b=bH0HwbH4zmygSQIN3X6n7gVHrhwjHjVlBNNKlzdRb7x/K6siI632129wczX1S1v6zBfuxq
        3i3XAaC3haBTcDnz4ahBs/4W45HZog9KySgVK6Vo7qpswKwO9gPeWaF4NQ0c6KycvHmgnG
        pLM0VSNmlFTTmEk8GH0e9/mwClrEiGg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-vA2S3ik2NfO8vrB9KFwFzA-1; Tue, 07 Jun 2022 20:28:40 -0400
X-MC-Unique: vA2S3ik2NfO8vrB9KFwFzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDFF580159B;
        Wed,  8 Jun 2022 00:28:39 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87C1840466A3;
        Wed,  8 Jun 2022 00:28:38 +0000 (UTC)
Date:   Wed, 8 Jun 2022 08:28:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rburanyi@google.com,
        Greg Thelen <gthelen@google.com>, viro@zeniv.linux.org.uk,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] kexec_file: Increase maximum file size to 4G
Message-ID: <Yp/tL5F7TFdwk8Sj@MiWiFi-R3L-srv>
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
 <20220527025535.3953665-3-pasha.tatashin@soleen.com>
 <Yp1s2c0hyYzM4hbz@MiWiFi-R3L-srv>
 <CA+CK2bC5U5j1xkZKuOETANo1=PPpbJn2mKYOa2fK1GLFib0ibw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bC5U5j1xkZKuOETANo1=PPpbJn2mKYOa2fK1GLFib0ibw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/07/22 at 12:02pm, Pasha Tatashin wrote:
> On Sun, Jun 5, 2022 at 10:56 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 05/27/22 at 02:55am, Pasha Tatashin wrote:
> > > In some case initrd can be large. For example, it could be a netboot
> > > image loaded by u-root, that is kexec'ing into it.
> > >
> > > The maximum size of initrd is arbitrary set to 2G. Also, the limit is
> > > not very obvious because it is hidden behind a generic INT_MAX macro.
> > >
> > > Theoretically, we could make it LONG_MAX, but it is safer to keep it
> > > sane, and just increase it to 4G.
> >
> > Do we need to care about 32bit system where initramfs could be larger
> > than 2G? On 32bit system, SSIZE_MAX is still 2G, right?
> 
> Yes, on 32-bit SSIZE_MAX is still 2G, so we are safe to keep 32-bit
> systems run exactly as today.
> 
> #define KEXEC_FILE_SIZE_MAX    min_t(s64, 4LL << 30, SSIZE_MAX)
> Is meant to protect against running over the 2G limit on 32-bit systems.

OK. In fact I was wrong. I386 doesn't have kexec_file loading support.

> 
> >
> > Another concern is if 2G is enough. If we can foresee it might need be
                          ~~ 4G, typo
> > enlarged again in a near future, LONG_MAX certainly is not a good
> > value, but a little bigger multiple of 2G can be better?
> 
> This little series enables increasing the max value above 2G, but
> still keeps it within a sane size i.e. 4G, If 4G seems too small, I
> can change it to 8G or 16G instead of 4G.

Just raising to try to discuss if 4G is enough. I have no knowledge
about how much is enough, and we don't need to guess, if you think 4G is
enough according to information you get, that's OK. We can wait a while
to see if other people have words about the vlaue. If no, then 4G is a
good one.

Thanks
Baoquan

