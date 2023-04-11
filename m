Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7766D6DD38E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 08:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjDKG7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 02:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjDKG7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:59:33 -0400
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Apr 2023 23:59:31 PDT
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C760D172C;
        Mon, 10 Apr 2023 23:59:31 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id C0849E0362; Tue, 11 Apr 2023 06:51:09 +0000 (UTC)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     a.p.zijlstra@chello.nl, bsingharora@gmail.com, corbet@lwn.net,
        juri.lelli@redhat.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@redhat.com, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn, huang.junhua@zte.com.cn,
        jiang.xuexin@zte.com.cn
Subject: Re: [PATCH linux-next] delayacct: track delays from IRQ/SOFTIRQ
Date:   Tue, 11 Apr 2023 14:51:09 +0800
Message-Id: <20230411065109.172037-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410213129.1d11261892767a61eacaefba@linux-foundation.org>
References: <20230410213129.1d11261892767a61eacaefba@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: Yes, score=6.7 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,FSL_HELO_NON_FQDN_1,HEADER_FROM_DIFFERENT_DOMAINS,
        HELO_NO_DOMAIN,NO_DNS_FOR_FROM,RCVD_IN_PBL,RDNS_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL_NO_RDNS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.4 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        *  0.0 FSL_HELO_NON_FQDN_1 No description available.
        *  3.6 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [193.203.214.57 listed in zen.spamhaus.org]
        *  1.0 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      ["yangyang[at]cgel.zte"[at]gmail.com]
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        *  0.2 FREEMAIL_FORGED_FROMDOMAIN 2nd level domains in From and
        *      EnvelopeFrom freemail headers are different
        *  1.3 RDNS_NONE Delivered to internal network by a host with no rDNS
        *  0.0 HELO_NO_DOMAIN Relay reports its domain incorrectly
        *  0.0 SPOOFED_FREEMAIL_NO_RDNS From SPOOFED_FREEMAIL and no rDNS
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> We're somewhat double-accounting.  Delays due to, for example, IO will
> already include delays from IRQ activity.  But it's presumably a minor
> thing and I don't see why anyone would care.

Thanks for your reviewing! I also think double-accounting should be OK, some
one who is tunning IO or IRQ could focus on the related delay respectively.
And PSI has the same logic when calculate IRQ or IO pressure. 
