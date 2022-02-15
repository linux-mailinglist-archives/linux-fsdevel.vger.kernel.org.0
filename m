Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785954B64E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 09:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbiBOIAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 03:00:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiBOIAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:00:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D101513E1C;
        Tue, 15 Feb 2022 00:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=GTP2UzZjDJ/eXfJiVbxrwoUWqxtFB5BjUt20GilxwjQ=; b=QtsoD8NEwdY2tVQ3f5N+LEGQ12
        Zozv4KRAydqq8jvzyYgl793cqDL26xo7eSPaKgHsgUWvmsRXEoxf+U3cWMUQpBk7PzxBTHkm651Go
        Cxhjh6rdefD4deUM9C5F4J66F43uLKLvi5drNBdEof3aLeTtKjIic9UqlyxryB3zGfmOQ46r1Y4ZK
        2L+AteKAIWmN/0yu0JsXPKdMKMqiecd/GL/gjxT5kWO4GNZkDaD1/D59bSJGSNIW9hnKCzWHji92G
        poTPASSp/9eUoDyMK9Toy9DWHuWhaGkzyKpSTw3LWVwss3oNDBdAJgYRg8uHt6y151yabCABUPE6e
        l2EAyPVw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJskk-001Rd5-2Q; Tue, 15 Feb 2022 08:00:02 +0000
Date:   Tue, 15 Feb 2022 00:00:02 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     =?utf-8?B?6IuP5a626K6t?= <sujiaxun@uniontech.com>
Cc:     keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: move oom_kill sysctls to their own file
Message-ID: <Ygtdgp9P8+887VMm@bombadil.infradead.org>
References: <20220215030257.11150-1-sujiaxun@uniontech.com>
 <YgtWZ0B7OzluiOkr@bombadil.infradead.org>
 <b86e23bf-1b90-6e31-66d9-10f9785ff8ed@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b86e23bf-1b90-6e31-66d9-10f9785ff8ed@uniontech.com>
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

On Tue, Feb 15, 2022 at 03:56:10PM +0800, 苏家训 wrote:
> I checked the patch using ./scripts/checkpatch.pl and found no errors.

./scripts/get_maintainer.pl, not checkpatch.

  Luis
>  
