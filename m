Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27327146CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 11:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjE2JCJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 05:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjE2JCI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 05:02:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DD79C;
        Mon, 29 May 2023 02:02:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7AD3921A1E;
        Mon, 29 May 2023 09:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685350924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFWz25ijAwtezsEsJfvwhWUN0ek5GmhRBcW2BirG67s=;
        b=ZN9ZFQLchBtUfvhRF6uJVCSPdqOdDMnq6D0bYEMlB3KVOifIJMpTqeRit28RmFuB1JOdNS
        a6OdjvKL/hU4tFlRyU+Plm1sA9CqI/54DiEz8Du0s3J4zlHeN8c1XLLbVjSwKRUlaZ2Lu1
        fzl6goxkg0Pa0yOH5RPLeFVJ+KRCsSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685350924;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFWz25ijAwtezsEsJfvwhWUN0ek5GmhRBcW2BirG67s=;
        b=HyCV5MkHcUPb0kFy0qNvwwus+4zH6Zgf5PAAuzQgvjAgqY1O+g2X1gcOkar74GwIfcUizj
        asUFBf3enD5OkHAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D02C13466;
        Mon, 29 May 2023 09:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4EuTGgxqdGRmYwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 29 May 2023 09:02:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 05276A0719; Mon, 29 May 2023 11:02:04 +0200 (CEST)
Date:   Mon, 29 May 2023 11:02:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Message-ID: <20230529090203.cbqst3rlkv2ejtnd@quack3.mediaserver.passengera.com>
References: <Y/gugbqq858QXJBY@ZenIV>
 <20230525201046.cth6qizdh7lwobxj@quack3>
 <5939173.lOV4Wx5bFT@suse>
 <2886258.e9J7NaK4W3@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2886258.e9J7NaK4W3@suse>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 26-05-23 15:25:18, Fabio M. De Francesco wrote:
> On venerdì 26 maggio 2023 12:32:59 CEST Fabio M. De Francesco wrote:
> > On giovedì 25 maggio 2023 22:10:46 CEST Jan Kara wrote:
> > > On Mon 27-03-23 12:29:56, Fabio M. De Francesco wrote:
> > > > On lunedì 20 marzo 2023 13:47:25 CEST Jan Kara wrote:
> > > > > On Mon 20-03-23 12:18:38, Fabio M. De Francesco wrote:
> > > > > > On giovedì 16 marzo 2023 11:30:21 CET Fabio M. De Francesco wrote:
> > > > > > > On giovedì 16 marzo 2023 10:00:35 CET Jan Kara wrote:
> > > > > > > > On Wed 15-03-23 19:08:57, Fabio M. De Francesco wrote:
> > > > > > > > > On mercoledì 1 marzo 2023 15:14:16 CET Al Viro wrote:
> > > > [snip]
> > > > 
> > > > > > > > > > I think I've pushed a demo patchset to vfs.git at some point
> > > > > > > > > > back
> > > > 
> > > > in
> > > > 
> > > > > > > > > > January... Yep - see #work.ext2 in there; completely 
> untested,
> > > > > > > > > > though.
> > > > 
> > > > Al,
> > > > 
> > > > I reviewed and tested your patchset (please see below).
> > > > 
> > > > I think that you probably also missed Jan's last message about how you
> > > > prefer
> > > > they to be treated.
> > > > 
> > > > Jan asked you whether you will submit these patches or he should just 
> pull
> > > > your branch into his tree.
> > > > 
> > > > Please look below for my tags and Jan's question.
> > > 
> > > Ok, Al didn't reply
> > 
> > I noticed it...
> > 
> > > so I've just pulled the patches from Al's tree,
> > 
> > Thank you very much for doing this :-)
> > 
> > > added
> > > your Tested-by tag
> > 
> > Did you also notice the Reviewed-by tags?
> > 
> 
> Well, it looks like you missed my Reviewed-by tags at https://lore.kernel.org/
> lkml/3019063.4lk9UinFSI@suse/
> 
> FWIW, I'd just like to say that I did the review of Al's patchset because I 
> know the code that is modeled after a similar series to fs/sysv, which in turn 
> I made following Al's suggestions.
> 
> However, I suppose it's up to you to decide whether or not is worth
> mentioning my reviews :-)

Yes, I've missed that you also gave your Reviewed-by tags. I will add
these. Thanks for the reminder :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
