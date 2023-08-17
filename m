Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3685177F819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 15:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351373AbjHQNxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 09:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243972AbjHQNwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:52:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B51E210D;
        Thu, 17 Aug 2023 06:52:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5AC671F37F;
        Thu, 17 Aug 2023 13:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692280368;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJxYoKOlaaNm5Uplf03K9+SNelS6VfaWNlFGWaSO/8g=;
        b=TFPHDsV4p/qJHx31Hmz/xhlJBk2YVyLPDEXrlKM+m4sY9cDR1aDmE/ptNe0cyrJdmfYdrC
        gqXG35/V2uIkPxE53IF2DmBqqjI2zu3OZCc/nxDhUjEyCX8IDv9asHbniV0+mATZEz/wqQ
        hzLa+EzQ9MM1EX2/l9ZCHn0PMMJbvoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692280368;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJxYoKOlaaNm5Uplf03K9+SNelS6VfaWNlFGWaSO/8g=;
        b=ZqSIQav10wClwaztfZKfli6OOShBhvraqurL8rDdf3QUZ6dtKGlFw2f+IHxZjhjfSHp07p
        j2P3sLQb0Yi7vsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3F731358B;
        Thu, 17 Aug 2023 13:52:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TycXLC8m3mTbDwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 13:52:47 +0000
Date:   Thu, 17 Aug 2023 15:46:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] fs/affs: Rename local toupper() to fn() to avoid
 confusion
Message-ID: <20230817134618.GT2420@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230817121217.501549-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817121217.501549-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 03:12:17PM +0300, Andy Shevchenko wrote:
> A compiler may see the collision with the toupper() defined in ctype.h:
> 
>  fs/affs/namei.c:159:19: warning: unused variable 'toupper' [-Wunused-variable]
>    159 |         toupper_t toupper = affs_get_toupper(sb);
> 
> To prevent this from happening, rename toupper local variable to fn.
> 
> Initially this had been introduced by 24579a881513 ("v2.4.3.5 -> v2.4.3.6")
> in the history.git by history group.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Added to affs tree, thanks.
