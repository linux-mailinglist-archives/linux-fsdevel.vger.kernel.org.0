Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0434098E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 18:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbhIMQY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 12:24:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43962 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbhIMQYL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:24:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F69021F04;
        Mon, 13 Sep 2021 16:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631550174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYIJjMUZ71LdWt3LZPpRDcVpejfYavC8pcMVWFXk4xc=;
        b=XzWy99yCsEm/z2O7vC69f8c4oFeKYr+7HKAiG/jpcThWcc+DdvAhWv0nhLgrozuCVnVBQC
        V0zpdzfqyCOKf9oggSPi59S9CYLfpGZcwLuZNg3BbxxN15Il4aksAlnnDW2sxyxED4fkkm
        TwqEPw6vnVbe5vAfXL2s5nZiwQDMCDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631550174;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYIJjMUZ71LdWt3LZPpRDcVpejfYavC8pcMVWFXk4xc=;
        b=3FHbKhAkit0Yk82HtVBY+Jnfn0Ch3Ts3Tkk/DRIxxeIyvcl8FGjrY6MRm7phn7suUq5fzz
        jTOCsTvArjBQCCAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57AA713AAB;
        Mon, 13 Sep 2021 16:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p4ZjFd56P2HnJQAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 13 Sep 2021 16:22:54 +0000
Date:   Mon, 13 Sep 2021 18:22:53 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seq_file: mark seq_get_buf as deprecated
Message-ID: <20210913162253.ofaaiycyo2kcvlbo@carbon.lan>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913054121.616001-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> + *
> + * DOT NOT USE IN NEW CODE! This function pokes a hole into the whole seq_file
> + * abstraction.  The only remaining user outside of seq_file.c is sysfs, which
> + * is gradually moving away from using seq_get_buf directly.
>   */

Maybe adding a check to checkpatch could also help?
