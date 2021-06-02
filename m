Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39EA398E6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 17:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhFBPVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 11:21:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46800 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhFBPVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:21:16 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DB58D219B2;
        Wed,  2 Jun 2021 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622647172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VmA0neGSQ6QDURkpVuR5VXTP3UMYcUDkmWxLieX+O5Y=;
        b=brEvVEzsg3yCc0WydToqaIyaiNWQK2byOY5aQpcij2VI8sM2vkM9I1EcnKVWsSZS2ILm3U
        a5aig50F1hC70nKjraKgZQ6jbg5TU+C3hLyla4r9LS9KkW6SXWdUlqo+C274vRLPdMa2UV
        4nZxT86gHiVEDGXPeMrv3/H88+XLKts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622647172;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VmA0neGSQ6QDURkpVuR5VXTP3UMYcUDkmWxLieX+O5Y=;
        b=anc6yynd6V1rw7wlLTe2MxU0w68mMApopPs4jqAOevygiE9xPLdoLzgbUPbN7Rc+SVXj1/
        FDvKmony2eGfTWCw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id C98C8A3BF5;
        Wed,  2 Jun 2021 15:19:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AF11A1F2CAC; Wed,  2 Jun 2021 17:19:32 +0200 (CEST)
Date:   Wed, 2 Jun 2021 17:19:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 0/2] Change quotactl_path() to an fd-based syscall
Message-ID: <20210602151932.GB23647@quack2.suse.cz>
References: <20210602151553.30090-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602151553.30090-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-06-21 17:15:51, Jan Kara wrote:
> Hello,
> 
> this patch series changes Sasha's quotactl_path() syscall to an fd-based one
> quotactl_fd() syscall and enables the syscall again. The fd-based syscall was
> chosen over the path based one because there's no real need for the path -
> identifying filesystem to operate on by fd is perfectly fine for quotactl and
> thus we can avoid the need to specify all the details of path lookup in the
> quotactl_path() API (and possibly keep that uptodate with all the developments
> in that field).
> 
> Patches passed some basic functional testing. Please review.

Sorry Christian, I've messed up your address when submitting this series...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
