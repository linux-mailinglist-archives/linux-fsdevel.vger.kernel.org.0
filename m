Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8D665FA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 16:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbjAKPt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 10:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbjAKPtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:49:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A853834D77
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 07:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673452093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mlR7fmjkyGH/tQKKBvJIkjgsqihiwiQFnkoLokXqB0M=;
        b=bGbNWXwqIkJ84g/8R1IuWj1XfuOYOipzOycFNKjej7B4m1GpMco/ScWXyWwx1FW9eJzyrZ
        sLbeadkt6+LdIp0HBQA21kLtK3rqOZgvRCVeLoArh1/g2XoejamJlVfQ4nIFHHfNVaxJyA
        zyWNhjY+tga0H2utmhovqJFEpaETG1M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-dHKN7Bk5MieQeWCzeEE6pQ-1; Wed, 11 Jan 2023 10:48:08 -0500
X-MC-Unique: dHKN7Bk5MieQeWCzeEE6pQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0B9A802D1B;
        Wed, 11 Jan 2023 15:48:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 408EC140EBF4;
        Wed, 11 Jan 2023 15:48:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1859d17668d.7b9d5469421579.5464668634216421773@siddh.me>
References: <1859d17668d.7b9d5469421579.5464668634216421773@siddh.me> <97ce37e2fdcfbed29d9467057f0f870359d88b89.1673173920.git.code@siddh.me> <cover.1673173920.git.code@siddh.me> <2121105.1673359772@warthog.procyon.org.uk>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     dhowells@redhat.com, "mauro carvalho chehab" <mchehab@kernel.org>,
        "randy dunlap" <rdunlap@infradead.org>,
        "jonathan corbet" <corbet@lwn.net>,
        "fabio m. de francesco" <fmdefrancesco@gmail.com>,
        "eric dumazet" <edumazet@google.com>,
        "christophe jaillet" <christophe.jaillet@wanadoo.fr>,
        "eric biggers" <ebiggers@kernel.org>,
        "keyrings" <keyrings@vger.kernel.org>,
        "linux-security-module" <linux-security-module@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] include/linux/watch_queue: Improve documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2430912.1673452085.1@warthog.procyon.org.uk>
Date:   Wed, 11 Jan 2023 15:48:05 +0000
Message-ID: <2430913.1673452085@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> But what about the second patch? Should I send that without these doc
> changes?

Can you repost it without the first patch being present?

David

