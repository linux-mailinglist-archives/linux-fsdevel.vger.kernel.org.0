Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623415B0940
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 17:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiIGPx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 11:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiIGPxb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:53:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBDF74E2A;
        Wed,  7 Sep 2022 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vh/HiySd7IixUJQ4SUop9TW+9NLt9KE49HmDRsCBipc=; b=t5FOdjDrVJnsnDIDkDKuH64BLF
        iDpHA3LR8azPZS3KvdZAi0Y9AWxn6iimlMQiKwKxCYrzFBbpR2+LDR9Lixe0Y+fi8PC1rCW37jYW6
        /6PTMIIDlbciXTTFaKyJIWsXeh/01gu0VCV18S0hRDUbgDYNeWhCn8UdUXsExLY7T2Pbzx5O3/9U+
        Eu0MI5W6nwLU5rNyELB/bH2SihYP8odXzIU0I1rX07Gmy4jdhpomGPEWuQ/6h53ybw8J3UbdzVzxH
        XE4WmovuAjlqh9oeCIXCscWtySB9wdaQW/LUnqAwVgEZcmLeMreKC4020cW5T3+g4dkVH1tUaYl26
        hLN1+Z3Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVxMj-007VRh-8k; Wed, 07 Sep 2022 15:53:25 +0000
Date:   Wed, 7 Sep 2022 08:53:25 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Will Deacon <will@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Stephen Kitt <steve@sk2.org>, Rob Herring <robh@kernel.org>,
        Joel Savitz <jsavitz@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Renaud =?iso-8859-1?Q?M=E9trich?= <rmetrich@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, Qi Guo <qguo@redhat.com>
Subject: Re: [PATCH] core_pattern: add CPU specifier
Message-ID: <Yxi+dQkuV2zdBzk3@bombadil.infradead.org>
References: <20220903064330.20772-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903064330.20772-1-oleksandr@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 03, 2022 at 08:43:30AM +0200, Oleksandr Natalenko wrote:
> Statistically, in a large deployment regular segfaults may indicate a CPU issue.

Can you elaborate on this? How common is this observed to be true? Are
there any public findings or bugs where it showed this?

  Luis
