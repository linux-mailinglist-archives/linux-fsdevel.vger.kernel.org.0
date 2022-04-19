Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D9B507BBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 23:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357907AbiDSVOm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 17:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357905AbiDSVOi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:14:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C94C2A24E;
        Tue, 19 Apr 2022 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XUSqcVdg0spSnmkggLG/VT+Cpf9iOYyjn8OPASpb5r0=; b=GzmSekdEIggeVCZKvlGzHIM7O/
        MnjQTR8Y0dutg4uEbqgFK5rDkhfeaI9hwSJjwOoi/8Z0I8cB4N6DpHNvuXjO5Nv/1PxQRRFQbaQG+
        vgb5kURU5/RidUxrvPonxYDhRd2k1RjoCcI9bTTTm4VF2FP12iBHXZ91UG8r8mjgF7pJmDfvu5juG
        Y9nVva19cvDpUfDW0/Jv0da+ahPVTazMwWe63iD7KTgZwrdAv8PdPWkpuPNIz3NjuF+uDCI46OsVD
        ClGp+Zh+F/f5Ac4bWIVSvPGsdWJ+bx72a0UMeaa3dEYyFOa3sZbwDkOzgkPGZYww2miMSOdqT7Sqa
        IQ2bzVLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngv8Z-003VTM-6f; Tue, 19 Apr 2022 21:11:51 +0000
Date:   Tue, 19 Apr 2022 22:11:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 1/4] lib/printbuf: New data structure for heap-allocated
 strings
Message-ID: <Yl8llyIN0vorOu/i@casper.infradead.org>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
 <20220419203202.2670193-2-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419203202.2670193-2-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 04:31:59PM -0400, Kent Overstreet wrote:
> +static const char si_units[] = "?kMGTPEZY";
> +
> +void pr_human_readable_u64(struct printbuf *buf, u64 v)

The person who wrote string_get_size() spent a lot more time thinking
about corner-cases than you did ;-)
