Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4225174BE09
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjGHPDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jul 2023 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjGHPDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jul 2023 11:03:38 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3C51723
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jul 2023 08:03:37 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-20-43-41.bstnma.fios.verizon.net [108.20.43.41])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 368F2oDH012499
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Jul 2023 11:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688828573; bh=s/ufTIvKew3KioKNVyg2UQzBrfALqHUfjES5Kq9/AZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=b9gouVI84+rzgMfB1n/SAVxyHOS4azQtXTf1FGYOj4HaXIOk4+LD2xqQyF3BytTUi
         kWlrn8Az+nlm6mfLjKCT11WsVZUmKAUp5PKALZalzCWib6Y5ugymFoIpUX7VwBBmrb
         5eshRO9DFgc36A0pWpQyoBYNR1WlJG/JKEIqfaIaOCQTOrX6rUAn4dxkTtSslFpLNO
         oUSkLXeitgD8lMy3p5sZ2y20ljh9URyckAwlZCg0kNwiHVqIfx51f4sNFstVX2AqhS
         QDUE6rHWkKceQkQADBYmgdxhoXAj1eAjoFceBv52RIMAWmQa7yGhJzcgxE8Ci7c5wh
         DoTFSaG5MakSg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E5DCA15C027F; Sat,  8 Jul 2023 11:02:49 -0400 (EDT)
Date:   Sat, 8 Jul 2023 11:02:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Matthew Wilcox <willy@infradead.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230708150249.GO1178919@mit.edu>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
 <20230706211914.GB11476@frogsfrogsfrogs>
 <20230707-badeverbot-gekettet-19ce3c238dac@brauner>
 <20230707091810.bamrvzcif7ncng46@moria.home.lan>
 <30661670c55601ff475f2f0698c2be2958e45c38.camel@HansenPartnership.com>
 <ZKjd7nQxvzRDA2tK@casper.infradead.org>
 <20230708043136.xj4u7mhklpblomqd@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708043136.xj4u7mhklpblomqd@moria.home.lan>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 08, 2023 at 12:31:36AM -0400, Kent Overstreet wrote:
> 
> I've long thought a more useful CoC would start with "always try to
> continue the technical conversation in good faith, always try to build
> off of what other people are saying; don't shut people down".

Kent, with all due respect, do you not always follow your suggested
formulation that you've stated above.  That is to say, you do not
always assume that your conversational partner is trying to raise
objections in good faith.  You also want to assume that you are the
smartest person in the room, and if they object, they are Obviously
Wrong.

As a result, it's not pleasant to have a technical conversation with
you, and as others have said, when someone like Christian Brauner has
decided that it's too frustating to continue with the thread, given my
observations of his past interaction with a wide variety of people,
including some folks who have been traditionally regarded as
"difficult to work with", it's a real red flag.

Regards,

					- Ted
