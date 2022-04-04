Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8B4F15A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 15:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350102AbiDDNSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 09:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiDDNSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:18:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409BD3CA78
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 06:16:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F41F21F383;
        Mon,  4 Apr 2022 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649078178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=wo7lOuiGReEE4mxUX5o5yxTJsIr4Oc+bVh5xTnx/mxI=;
        b=IUKFOOSyP8hFYfLo/+g0q7/VHq5m4LlHh+5a5UJxI2BIUoQYBBbZppXGhlACUJT+LYSbGa
        rf9J5xta+y1DicRLfgicvMX0CxXOCiPMPmrz/ssZc4v4etlZDtz/UIakhappsDK4CUB3WC
        AJ7nMAsyZv9kYJfH6gpXV8UUqv4M4pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649078178;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=wo7lOuiGReEE4mxUX5o5yxTJsIr4Oc+bVh5xTnx/mxI=;
        b=3e5TQI9rW6PwllBvQoukMvyGGz2oSAXLvPSLdRY60l4Fb6tC+NEv7OFOdK5oatt3Fycmtg
        VooS3baEIQHvY2Bw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E6192A3B88;
        Mon,  4 Apr 2022 13:16:17 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 140BDA0615; Mon,  4 Apr 2022 15:16:17 +0200 (CEST)
Date:   Mon, 4 Apr 2022 15:16:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     contact@archlinuxarm.com
Cc:     linux-fsdevel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Reiserfs deprecation
Message-ID: <20220404131617.jln4zsifv6azgltj@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I'm not sure if this is the right address to contact, please redirect me if
not. Pavel Machek has notified me he's recently seen an ArchLinux ARM
distro on PinePhone using reiserfs. Reiserfs is unmaintained filesystem for
quite a few years and thus it is not a good idea to put user data on it
(the chances it will loose data or crash the kernel are growing). Because of
the lack of maintenance we plan to actually remove it from the kernel in a
few years. I wanted to warn you early so that you have enough time to plan
how to stop using reiserfs and migrate to another filesystem...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
