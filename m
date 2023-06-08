Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083A472767F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 07:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjFHFGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 01:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjFHFGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:06:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C8E13D;
        Wed,  7 Jun 2023 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hboq8DS3pZaL6NixiwlkXIeXNphhjLHYiMYmQAdycXs=; b=Q00dNRefDVcWXDKo3oxAmnUK+Y
        sFTBS9bSwpbmXHCG4EwlX1qCnlzqbGWQsmpLWsmcQNpJIDuFuAmPmaiSu/Ez4Y+nR7oqcjaYVnjTL
        /hJgcPMiA6CUfQD8W0cHCxVsx91YthI/i4ySXHwZlzl1JdbZMgWoVJWPGcZmuW+c+tw5ZUIgCSx+G
        hEKfIC7v+UW9YzJSEvPdIYBOHx+5Kr5JBOr7C1BZm1iYmpP+QQ87LkvH3Fj96JJTRGHlr/9v5++Lx
        m7z9EUWwWFCkzXdzm6ujtDRDiVLy0haNZr6abgK6mGvbUTtE5Kv1mqV2mAKhLj5rzHMHjUxPf5J8X
        JkuoWFJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q77qE-00878e-2Q;
        Thu, 08 Jun 2023 05:05:46 +0000
Date:   Wed, 7 Jun 2023 22:05:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] fs: add frozen sb state helpers
Message-ID: <ZIFhqk6VElD6qXBU@infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508011717.4034511-3-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 07, 2023 at 06:17:13PM -0700, Luis Chamberlain wrote:
> Provide helpers so that we can check a superblock frozen state.
> This will make subsequent changes easier to read. This makes
> no functional changes.

I'll look at the further changes, but having frozen/unfrozen helpers
that sound binary while we have 4 shades of gray seems rather confusing
to me.

