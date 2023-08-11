Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93641778692
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 06:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjHKEhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 00:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHKEhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 00:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FA32686;
        Thu, 10 Aug 2023 21:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58FBC63346;
        Fri, 11 Aug 2023 04:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A174C433C8;
        Fri, 11 Aug 2023 04:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691728672;
        bh=oM3J+HVnI97b6e/ppsDoFWW8Qty/fxY7Rh8duwlKvUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ea2MI1M4M8Dw/ox1lQePpfUuORPD9a3DC/NS4MLPgTllPv+LLun1HVt23zY6TRwl6
         C5DSfr3mJuz8QeOZlspmikVejYhmppu2usBzHP+o0eTEEVCt5E9zYKyrFblbjQN7P+
         h+KXKA5K7WOF8IDI4pyTJ7RYeIqLZzkiooLECBPaPA2C2yfwEXhf2kMfd9FpKF8ZZ5
         gx7syZKLMudzKsSx1GUWQbnD5+6hgExBaVzwONoIIPJMWWDaAxTdhamxM609SYfFKa
         cGaKIGH2nlFJK16vvE7DIYFOn1l6hRegX5n1P+3amh8TkQHE2n6BwBjiMLC80J20WG
         mNptodM1vxr6A==
Date:   Thu, 10 Aug 2023 21:37:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Zhang Zhiyu <zhiyuzhang999@gmail.com>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: A Discussion Request about a maybe-false-positive of UBSAN: OOB
 Write in do_journal_end in Kernel 6.5-rc3(with POC)
Message-ID: <20230811043750.GA1934@sol.localdomain>
References: <CALf2hKvsXPbRoqEYL8LEBZOFFoZd-puf6VEiLd60+oYy2TaxLg@mail.gmail.com>
 <20230809153207.zokdmoco4lwa5s6b@quack3>
 <20230810051521.GC923@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810051521.GC923@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 10:15:23PM -0700, Eric Biggers wrote:
> On Wed, Aug 09, 2023 at 05:32:07PM +0200, Jan Kara wrote:
> > Improving kernel security is certainly a worthy goal but I have two notes.
> > Firstly, reiserfs is a deprecated filesystem and it will be removed from
> > the kernel in a not so distant future. So it is not very useful to fuzz it
> > because there are practically no users anymore and no developer is
> > interested in fixing those bugs even if you find some. Secondly, please do
> > a better job of reading the code and checking whether your theory is
> > actually valid before filing a CVE (CVE-2023-4205). That's just adding
> > pointless job for everyone... Thanks!
> 
> FYI I filled out https://cveform.mitre.org/ to request revocation of this CVE.
> 
> - Eric

Just to follow up on this, the CVE has now been "rejected".  For future
reference, MITRE had me contact Red Hat since they issued the CVE.  So the right
procedure was to email secalert@redhat.com, not fill out the CVE form.

- Eric
