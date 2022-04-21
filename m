Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430B450A389
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389818AbiDUPDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 11:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389901AbiDUPC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:02:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047122F029
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 08:00:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AFF10210EC;
        Thu, 21 Apr 2022 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650553207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hz4sTeXzxa4hC2YfoCf8UBHVoyrdYpL8bK5K9hZFgQw=;
        b=JKeiQTKGbOKaTni1DQLEcPFIvoLqQD1GSmGNuoZ//yxf33KeoI7I3dSY0FOJ8S4++e/RNz
        8QDMUYr5JuDdqLTQFz2R+To3saw0097UPPyZKRX3faTfSZhvA5yA5y6mzlq/1E6BdNr5bR
        phgXkeK7vmCt9fx8ywQrASL0Zf2ESak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650553207;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hz4sTeXzxa4hC2YfoCf8UBHVoyrdYpL8bK5K9hZFgQw=;
        b=yNoD2ADTks9CBr2DzEI3O5kJ37i86dE1EpQ+xlJJJc3nanGQBy065M7FpEJ9fXphOmnW2l
        G5OrrMukIT4K0nBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9ACD32C141;
        Thu, 21 Apr 2022 15:00:07 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 39CCBA0620; Thu, 21 Apr 2022 17:00:07 +0200 (CEST)
Date:   Thu, 21 Apr 2022 17:00:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 13/16] fanotify: factor out helper
 fanotify_mark_update_flags()
Message-ID: <20220421150007.ytjvw5fe7hfqihwv@quack3.lan>
References: <20220413090935.3127107-1-amir73il@gmail.com>
 <20220413090935.3127107-14-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413090935.3127107-14-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-04-22 12:09:32, Amir Goldstein wrote:
> Handle FAN_MARK_IGNORED_SURV_MODIFY flag change in a helper that
> is called after updating the mark mask.
> 
> Move recalc of object mask inside fanotify_mark_add_to_mask() which
> makes the code a bit simpler to follow.
> 
> Add also helper to translate fsnotify mark flags to user visible
> fanotify mark flags.

This bit got moved to another commit. Otherwise changes look good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
