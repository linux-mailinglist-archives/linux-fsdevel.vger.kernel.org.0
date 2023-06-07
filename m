Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5661725B83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 12:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjFGKXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 06:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjFGKXA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:23:00 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14391BD6;
        Wed,  7 Jun 2023 03:22:59 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bb15165ba06so6267248276.2;
        Wed, 07 Jun 2023 03:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686133379; x=1688725379;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=11Qj+9mJ+vIJcJp0to9dR/s2fBZqmU6HPJipmH3PI1A=;
        b=OaKGhAk+7pdFO/Zzi1uPt/RpW3Ia2xTlJvG0uTK8e6V+rIFUYNzSuD6cK9ym3BskWD
         TBVTfZ+CVGIkXhhFgiG2FXOqBo4leVqFIGgVHvgJt3byKJt6WiJMLBt1aYzT40uzSp2l
         uvU9T8YnjTAsRk7mgcruWWZGkbjsg6cUiVNwkHOE/UmR/NXWgIVbi1ns2qO3bDTLb/lj
         bUyzi+uPGcfr0C4ptu/rUS2hDhwmdHdJpOOosqILcE2eac6AxAlhGUtZE4RQkYuVdchw
         LMqhGwJoh4HtoEVeIg0BARAmE0aU73JSieDiHLRYbQm1FI+1IG55M0Tu5Jr910/zVV14
         AMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686133379; x=1688725379;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11Qj+9mJ+vIJcJp0to9dR/s2fBZqmU6HPJipmH3PI1A=;
        b=C9uuzfT+FqpLF/aTp668+pKLsJj9ObMJMnj2reTBzKrngTnGnbixyIa7zynglGGyMY
         n/6YpGqVxY9fKVkr1eGK0Bg7m/T0GFHk7gA/d11TfthSdZDMZANoYRqqWZ8tWbcrdoVB
         m5SR/+XJqezTrAxoPeK9SrjMOXGjwSOnb1IQRm9jIvP6hVoE1tpEaytyK/yk/p7oEfJ2
         l8bMQCDvIW53KZSiTiC4PF/T3XE8/qXgam3ZeyLcKndVRQOI0na42DpWQSjXTyzRHdNS
         uqWPDjYJj9gXnnx85QGfFgcICwvierzCiFY6BILFs90QEG9qI5xLSuollsuaNGiYiMyv
         mDvQ==
X-Gm-Message-State: AC+VfDzL2MAWippU85tkNx5DQz0LimBU3t59jNV48Jfzu/gHAQtunZ0U
        NmlIGak+6yw05J3vfQc13jI=
X-Google-Smtp-Source: ACHHUZ7jj1DSchPRIjbzuMy/0paqNMYo7rzFuj3sJYdLxmD2xzeglgwXOl4t+dbVhRrwvZmbQF1nLg==
X-Received: by 2002:a25:2f54:0:b0:ba6:c383:4885 with SMTP id v81-20020a252f54000000b00ba6c3834885mr4415595ybv.12.1686133379072;
        Wed, 07 Jun 2023 03:22:59 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id k14-20020a170902760e00b001b03a1a3173sm887833pll.145.2023.06.07.03.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:22:58 -0700 (PDT)
Date:   Wed, 07 Jun 2023 15:52:54 +0530
Message-Id: <875y7zk1vl.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv8 0/5] iomap: Add support for per-block dirty state to improve write performance
In-Reply-To: <ZIAoM+XL8bj1usM3@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> FYI, daily reposts while there is still heavy discussion ongoing
> makes it really hard to chime into the discussion if you get preempted..

Sure, noted. 
Thanks again for the help and review!

-ritesh
