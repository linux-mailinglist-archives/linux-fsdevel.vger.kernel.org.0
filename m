Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28904BAFE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 03:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiBRCw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 21:52:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiBRCw5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:52:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD3C33353;
        Thu, 17 Feb 2022 18:52:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7767B8252F;
        Fri, 18 Feb 2022 02:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B833C340E8;
        Fri, 18 Feb 2022 02:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645152759;
        bh=TeFjMTPKudnuPNupQPgpIs4VobDLmUqvoLOXVzdM5l8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GVICjndYP0SP19/ZfjxEzQhFzFsknep5K6k5cegCm2FgMiPKkrEJckFllHJQH+yQ9
         5mddJ1tfZWWOJdW31WKHbmNCZ/jcnbwf8chqZ+Dg6cB+8556HOFNwmWstbr7IDJ6jB
         QJAP1WQZ+BSS2VFVyNSCkPaixVjQU6/DFsHkmA0E=
Date:   Thu, 17 Feb 2022 18:52:38 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Zhen Ni <nizhen@uniontech.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH v3 0/8] sched: Move a series of sysctls starting with
 sys/kernel/sched_*
Message-Id: <20220217185238.802a7e2dd1980fee87be736c@linux-foundation.org>
In-Reply-To: <Yg3+bAQKVX+Dj317@bombadil.infradead.org>
References: <20220215114604.25772-1-nizhen@uniontech.com>
        <Yg3+bAQKVX+Dj317@bombadil.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Feb 2022 23:51:08 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:

> Are you folks OK if say Stephen adds a sysctl-next for linux-next so
> we can beat on these there too?

Sure.  I just sent you a couple which I've collected.
