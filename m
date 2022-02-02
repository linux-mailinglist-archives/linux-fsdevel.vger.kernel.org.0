Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0204A6EDB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 11:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiBBKjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 05:39:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbiBBKjv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643798391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoKcDNYv8j/VeKiP0Omhc2m0cD1wc6xhimo7A/L32Fs=;
        b=GVgA/k7ZqCzTOngnnp89SlVrzOIzJuiuWf/hoKDI1LRnrUCBmezt5BO+CmRRFlF+ZfNaFB
        taSv0YdEZMc8se8uoJXrAP3sNwTm8w+9gYmBXONmjzjNgbeyRiefW92A2QrG5QitbRpChB
        xRkeOPt/hI3P4hvJ5WYZYkj/lAjy3FI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-xDd734xaMPmbmtXjI3HhBg-1; Wed, 02 Feb 2022 05:39:49 -0500
X-MC-Unique: xDd734xaMPmbmtXjI3HhBg-1
Received: by mail-wm1-f70.google.com with SMTP id c7-20020a1c3507000000b0034a0dfc86aaso3606624wma.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Feb 2022 02:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=RoKcDNYv8j/VeKiP0Omhc2m0cD1wc6xhimo7A/L32Fs=;
        b=1k2P54fzBHK44knpmeuqI9/LlF3QAIflSlyL3/X3CFHDdBSh0iRL5e/2vfB0SWpfxc
         R6U/iG+7MZqbq3wSCsQTAonop0/9llV8y4Ug3lPn/2scxNY70sSoRgycNHS4hOzYtx//
         Ha/jpWu+HzBLcL69SNspJlN958QpgtH9a7sUTw8gnVtpwJFpaz0Lywu/eQM5LAza+aOm
         YGqiPPFh7nyKMhpmKUnaY4lQG0aZtT0rBdgXmNQlL5t5LF5zTIartVe+NP8oX6jB9oQ1
         uGCmdeUqI/06kiApmqakELXQngM1AiLPBnVQ92Qy/NPkwfwt/AYCjR2GYzA7Kd8AfJ41
         FYow==
X-Gm-Message-State: AOAM530xjRiOnkpJ1Ss/JQustU3VkrJGi4ru0wRPuR9ial8vIxERMBjw
        ukp77vPKHUkz8X0V++9UfSKRCfi5EdQb65vPvlF5O5a3FowZhzxHyQ/Qe1ZB6MWFDc4TKB5vQAL
        ej+yt4j2Sq59W38sOVjnZXutZtQ==
X-Received: by 2002:adf:f045:: with SMTP id t5mr24320170wro.387.1643798388725;
        Wed, 02 Feb 2022 02:39:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0Vbc9BBBx+eddKjTX8GKSZh+hlZGS8LR8J8tm4h8Kn5ZWpqhixHYoT13Mma94/gREduzJzg==
X-Received: by 2002:adf:f045:: with SMTP id t5mr24320155wro.387.1643798388470;
        Wed, 02 Feb 2022 02:39:48 -0800 (PST)
Received: from 0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa (0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:ffda:0:2059:8730:b2:c370])
        by smtp.gmail.com with ESMTPSA id i19sm5229158wmq.45.2022.02.02.02.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 02:39:48 -0800 (PST)
Message-ID: <8eb568cc9a440513e595835a56c78fdd03b5f2a9.camel@redhat.com>
Subject: Re: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
From:   Steven Whitehouse <swhiteho@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>, dhowells@redhat.com
Date:   Wed, 02 Feb 2022 10:39:46 +0000
In-Reply-To: <20220201013329.ofxhm4qingvddqhu@garbanzo>
References: <20220201013329.ofxhm4qingvddqhu@garbanzo>
Organization: Red Hat UK Ltd
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Mon, 2022-01-31 at 17:33 -0800, Luis Chamberlain wrote:
> It would seem we keep tacking on things with ioctls for the block
> layer and filesystems. Even for new trendy things like io_uring [0].
> For a few years I have found this odd, and have slowly started
> asking folks why we don't consider alternatives like a generic
> netlink family. I've at least been told that this is desirable
> but no one has worked on it. *If* we do want this I think we just
> not only need to commit to do this, but also provide a target. LSFMM
> seems like a good place to do this.
> 
> Possible issues? Kernels without CONFIG_NET. Is that a deal breaker?
> We already have a few filesystems with their own generic netlink
> families, so not sure if this is a good argument against this.
> 
> mcgrof@fulton ~/linux-next (git::master)$ git grep
> genl_register_family fs
> fs/cifs/netlink.c:      ret =
> genl_register_family(&cifs_genl_family);
> fs/dlm/netlink.c:       return genl_register_family(&family);
> fs/ksmbd/transport_ipc.c:       ret =
> genl_register_family(&ksmbd_genl_family);
> fs/quota/netlink.c:     if (genl_register_family(&quota_genl_family)
> != 0)
> mcgrof@fulton ~/linux-next (git::master)$ git grep
> genl_register_family drivers/block
> drivers/block/nbd.c:    if (genl_register_family(&nbd_genl_family)) {
> 
> Are there other reasons to *not* use generic netlink for new
> features?
> For folks with experience using generic netlink on the block layer
> and
> their own fs, any issues or pain points observed so far?
> 
> [0] 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=nvme-passthru-wip.2&id=d11e20acbd93fbbcdaf87e73615cdac53b814eca
> 
>   Luis
> 

I think it depends very much on what the interface is, as to which of
the available APIs (or even creating a new one) is the most appropriate
option.

Netlink was investigated a little while back as a potential interface
for filesystem notifications. The main reason for this is that it
solves one of the main issues there, which is the potentially unbounded
number of notifications that might be issued into a queue of finite
capacity. Netlink was originally designed for network routing messages
which have a similar issue. As such a mechanism was built in to allow
dropping of messages when the queue overflows, but in a way that it is
known that this has happened, so one can then resync from the kernel's
information. For things such as mount notifications, which can be
numerous in various container scenarios, this is an important
requirement.

However, it is also clear that netlink has some disadvantages too. The
first of these is that it is aligned to the network subsystem in terms
of namespaces. Since the kernel has no concept of a container per se,
the fact that netlink is in the network namespace rather than the
filesystem namespace makes using it with filesystems more difficult.
Another issue is that netlink has gained a number of additional
features and layers over the years, leading to some overhead that is
perhaps not needed in applications on the filesystem side.

That is why, having carefully considered the options David Howells
created a new interface for the notifications project. It solves the
problems mentioned above, while still retaining the advantages or being
able to deal with producer/consumer problems.

I'm not sure from the original posting though exactly which interfaces
you had in mind when proposing this topic. Depending on what they are
it is possible that another solution may be more appropriate. I've
included the above mostly as a way to explain what has already been
considered in terms of netlink pros/cons for one particular
application,

Steve.



