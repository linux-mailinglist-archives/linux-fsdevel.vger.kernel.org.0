Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666124DC8B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 15:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiCQO1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 10:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiCQO1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:27:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDC2193B5F
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 07:25:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 364F01F38D;
        Thu, 17 Mar 2022 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647527142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JThH1urLKyE59pVKFQZXXta4Ltmc+/JnIf7vGajx1Uc=;
        b=pMSDbR6ZtveED9pSbHN5SpQqSUKX9mf313NLCST69/1pdAUy6Z6dVMa2BYx2+CnrFI3NRx
        6P8ubLR2Olkw2SSSwIskgzmZ+Y4j7PuUo4lNUKunHIFsMYGn4faFV4Tj0ZfQ68v/N4vKXd
        EEryFCiuUt7oMGrERZ53YuRHW5/c1HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647527142;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JThH1urLKyE59pVKFQZXXta4Ltmc+/JnIf7vGajx1Uc=;
        b=Slzy/6+GqUSnvi1EGCBMtLDWyrYTkhODxYZqjyGtkR/2MLp8BsaLSo6OHbfoMaIlge/gWo
        QV2ok+Vi8OxNVwCA==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 226EFA3B87;
        Thu, 17 Mar 2022 14:25:42 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A4FAFA0615; Thu, 17 Mar 2022 15:25:41 +0100 (CET)
Date:   Thu, 17 Mar 2022 15:25:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] fsnotify: move inotify control flags to mark flags
Message-ID: <20220317142541.shlwdtb4ujusce4u@quack3.lan>
References: <20220307155741.1352405-1-amir73il@gmail.com>
 <20220307155741.1352405-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307155741.1352405-2-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 07-03-22 17:57:37, Amir Goldstein wrote:
> The inotify control flags in the mark mask (e.g. FS_IN_ONE_SHOT) are not
> relevant to object interest mask, so move them to the mark flags.
> 
> This frees up some bits in the object interest mask.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. I'm just wondering: Can we treat FS_DN_MULTISHOT in a similar way?

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
