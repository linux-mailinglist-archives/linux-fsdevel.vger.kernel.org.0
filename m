Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980DE70123B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 May 2023 00:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbjELWjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 18:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjELWji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 18:39:38 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565898E;
        Fri, 12 May 2023 15:39:36 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 721B958740D62; Sat, 13 May 2023 00:39:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 6FD0960C37E19;
        Sat, 13 May 2023 00:39:34 +0200 (CEST)
Date:   Sat, 13 May 2023 00:39:34 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Kent Overstreet <kent.overstreet@linux.dev>
cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 04/32] locking: SIX locks (shared/intent/exclusive)
In-Reply-To: <ZF6oejsUGUC0gnYx@moria.home.lan>
Message-ID: <o52660s0-3s6s-9n74-8666-84s2p4qpoq6@vanv.qr>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev> <20230509165657.1735798-5-kent.overstreet@linux.dev> <7233p553-861o-9772-n4nr-rr5424prq1r@vanv.qr> <ZF6oejsUGUC0gnYx@moria.home.lan>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Friday 2023-05-12 22:58, Kent Overstreet wrote:
>On Thu, May 11, 2023 at 02:14:08PM +0200, Jan Engelhardt wrote:
>> >+// SPDX-License-Identifier: GPL-2.0
>> 
>> The currently SPDX list only knows "GPL-2.0-only" or "GPL-2.0-or-later",
>> please edit.
>
>Where is that list?

I just went to spdx.org and then chose "License List" from the
horizontal top bar menu.
