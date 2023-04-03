Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB6C6D4D4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 18:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjDCQNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjDCQN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:13:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CBD10FC;
        Mon,  3 Apr 2023 09:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VrOsgLk4nRQ8eCcYXvi/Wkky3os3Gtp9NYdLIsxycCc=; b=s1nuSSV6nvabiV/r2mfwmVeyyf
        u4auUr+Z7lW8PuJNf1yO5bgaJny1SVKTSoEt/2SeJVkjx/KtLlZ2DOlz8YyJ7/nvv9XktIqmtTCdj
        WcZCj1wLv1K9yKzZ7KD0k95rNGyakG3S6uDNlKuu28lIDN6BS0FvF9AxS78vgyXHH1tgNTnKzfXih
        25Y3xw0SdAaZpO0KhpXmB++bNKZcbZ6z2WhPZI9XOfzydB6seqSiJ3nH1+TrDEsIH2ON/pwVx9m7l
        hSuMzf7Z8DEyMdAk30cQ02PYcFi9+7XEAuFBgfDWcmf7mMUEBiu0ml+n4+nQbFVR8xFIfjmcVO/x4
        AjPujZmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjMo3-00EHFm-Ut; Mon, 03 Apr 2023 16:13:19 +0000
Date:   Mon, 3 Apr 2023 17:13:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs/buffer: Remove redundant assignment to err
Message-ID: <ZCr7H9NqkPlmR/jk@casper.infradead.org>
References: <20230323023259.6924-1-jiapeng.chong@linux.alibaba.com>
 <167990444020.1656778.1662705570875208111.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167990444020.1656778.1662705570875208111.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 10:10:10AM +0200, Christian Brauner wrote:
> 
> On Thu, 23 Mar 2023 10:32:59 +0800, Jiapeng Chong wrote:
> > Variable 'err' set but not used.
> > 
> > fs/buffer.c:2613:2: warning: Value stored to 'err' is never read.
> > 
> > 
> 
> Applied to

I think you should exercise extreme care with patches from "Abaci Robot".
It's wrong more often than it's right, and the people interpreting the
output from it do not appear to be experienced programmers.
