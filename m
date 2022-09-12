Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155DC5B58FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 13:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiILLGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 07:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiILLGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:06:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214063846A;
        Mon, 12 Sep 2022 04:06:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ABC0C21BD8;
        Mon, 12 Sep 2022 11:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662980806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JFfKsEJCnEsN6K/ZOnFRpHquA013o9Cgg/nI6c7TQfw=;
        b=EOljgpUmmWH3W9vHYeip7CSsJFeqsrfDN9sWHZUXsw3Iwya8Shx7tGKPFdIlDAGs14tO77
        x+Vs2MQwE/va5I1rZ6GVpE5OUDwjmkCVsRn3NmYs3Kc1urrHTUChitAFIyTs+O7nkXNCpC
        ZrkxxLwYRxXsWinTrwmq0OZbM+IMzvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662980806;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JFfKsEJCnEsN6K/ZOnFRpHquA013o9Cgg/nI6c7TQfw=;
        b=LPFV/gSN6MUeSfM9OdayI02aPIJZW79O8KIS2QozGqu5tPGwfP+Q8Aq1hGe3Z49dBzEtMU
        4PHmMiXDWxjtC7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D92F139E0;
        Mon, 12 Sep 2022 11:06:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /yF0JsYSH2OBbwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Sep 2022 11:06:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 34354A067E; Mon, 12 Sep 2022 13:06:46 +0200 (CEST)
Date:   Mon, 12 Sep 2022 13:06:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: Re: [fs] 36e2c7421f: xfstests.generic.095.fail
Message-ID: <20220912110646.bn4q2vh5jxii7zrx@quack3>
References: <202209081443.593ab12-yujie.liu@intel.com>
 <20220909144406.GA10618@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909144406.GA10618@lst.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 09-09-22 16:44:06, Christoph Hellwig wrote:
> On Thu, Sep 08, 2022 at 03:01:57PM +0800, kernel test robot wrote:
> > Hi Christoph,
> > 
> > According to the commit message of below patch, we understand that it
> > removes splice support for some device drivers, but we don't have enough
> > knowledge to connect the code change with testcase result. We send this
> > report for your reference, please kindly check if it is an expected
> > result. Thanks.
> 
> This might be as simple wiring up iter_file_splice_write, but I don't
> really have a good way to test udf, so adding the maintainer.

Indeed. Thanks for notifying me. Just adding:

.splice_write           = iter_file_splice_write,

to udf_file_operations fixes the problem for me and generic/095 passes
fine. I've queued the fix to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
