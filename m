Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04B6580236
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 17:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiGYPt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiGYPt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:49:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FFFE030
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jul 2022 08:49:56 -0700 (PDT)
Date:   Mon, 25 Jul 2022 17:49:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658764194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5PCQz64XXfRnj3WeHjA45VIFb69hjN5CcvDVEE4Ow8=;
        b=piMetjZYZ/7S9iw7Ma3pHSu8l3tjhC2E5slODdeCoUEKcw3zoZdWSFOuKGAESO1UDBLgYp
        nYvpRg1b3OpCE6ytZtIHo2oWUNj+RZRfUCMRCDoFyvvCQCP3Kl8C1hRzJrErK1eSp93VAc
        oMTz7o/E9SF+kIfEmxqZkNz+LK0iLaXIorSCgqSMyHddvpQz15BiN4ahZC4vQmC/txSrT/
        J9ZaoFYMLZ1NS7Zhsb7WGQ9iCQAKAPe+nGzYXGAJsaqBZVV1qvJACKnf8XaO9zTxINdqmv
        ZeFopnSV2TZ/PHo7otFGotjceH/RSGtxB2LeR3XQTT3b/eNCuza38voflwEidA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658764194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5PCQz64XXfRnj3WeHjA45VIFb69hjN5CcvDVEE4Ow8=;
        b=XdM8iU+RhuYuMaaa4jTLsL+7OyHRJsfncF2W6TI89y23h0drhU4HApzrRpppDfilb1Dad5
        hIwpShkXumfDC8BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: fs/dcache: Resolve the last RT woes.
Message-ID: <Yt67oVwV1XtLMMF9@linutronix.de>
References: <20220613140712.77932-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220613140712.77932-1-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-06-13 16:07:08 [+0200], To linux-fsdevel@vger.kernel.org wrote:
> PREEMPT_RT has two issues with the dcache code:

a polite ping for the series. This is one of two road blocks to get RT
enabled in v5.20. I don't want to add any pressure just point out that I
can't sit still for days since the end is near ;)

Sebastian
