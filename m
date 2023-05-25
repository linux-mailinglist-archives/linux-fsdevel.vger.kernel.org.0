Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3C77117E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 22:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbjEYUKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 16:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbjEYUKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 16:10:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94BC9B;
        Thu, 25 May 2023 13:10:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 934C121900;
        Thu, 25 May 2023 20:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685045446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hq78prvpqK+0+yurD5QWLy6AtRXjlqEAnbV+QgwIthY=;
        b=f5iDpVUpbRXENQYHAhQd8gnxlIAzNVvflxj8Gwtpgxavu7fBu2cmHE1NcsgQdayJ5VB3b3
        GYiOYDZSbla2cO8n0zTzpR2GQppFdGMbRjepUxCysDl/VxA6tQQNe89t8MuU7qsrcwngvt
        MBzZveY+wAptU2VARxTqisbLaxl7PIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685045446;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hq78prvpqK+0+yurD5QWLy6AtRXjlqEAnbV+QgwIthY=;
        b=rcqn0ys/CKLXGKb/FKUEfBxrIP2J4q88H3k5A2br3Sn6G3CNtmkdIE7n1hQYm+1zJiyDV9
        B+qxj+XlzAdMXYCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8159A13356;
        Thu, 25 May 2023 20:10:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sEhzH8bAb2TsDAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 20:10:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 12FFDA075C; Thu, 25 May 2023 22:10:46 +0200 (CEST)
Date:   Thu, 25 May 2023 22:10:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Message-ID: <20230525201046.cth6qizdh7lwobxj@quack3>
References: <Y/gugbqq858QXJBY@ZenIV>
 <4214717.mogB4TqSGs@suse>
 <20230320124725.pe4jqdsp4o47kmdp@quack3>
 <3307436.0oRPG1VZx4@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3307436.0oRPG1VZx4@suse>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 27-03-23 12:29:56, Fabio M. De Francesco wrote:
> On lunedì 20 marzo 2023 13:47:25 CEST Jan Kara wrote:
> > On Mon 20-03-23 12:18:38, Fabio M. De Francesco wrote:
> > > On giovedì 16 marzo 2023 11:30:21 CET Fabio M. De Francesco wrote:
> > > > On giovedì 16 marzo 2023 10:00:35 CET Jan Kara wrote:
> > > > > On Wed 15-03-23 19:08:57, Fabio M. De Francesco wrote:
> > > > > > On mercoledì 1 marzo 2023 15:14:16 CET Al Viro wrote:
> 
> [snip]
> 
> > > > > > > I think I've pushed a demo patchset to vfs.git at some point back 
> in
> > > > > > > January... Yep - see #work.ext2 in there; completely untested,
> > > > > > > though.
> 
> Al,
> 
> I reviewed and tested your patchset (please see below).
> 
> I think that you probably also missed Jan's last message about how you prefer 
> they to be treated.
> 
> Jan asked you whether you will submit these patches or he should just pull 
> your branch into his tree.
> 
> Please look below for my tags and Jan's question.

Ok, Al didn't reply so I've just pulled the patches from Al's tree, added
your Tested-by tag and push out the result into linux-next.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
