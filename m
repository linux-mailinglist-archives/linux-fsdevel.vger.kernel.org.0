Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186496EDA3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 04:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjDYCfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 22:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjDYCfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:35:16 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44F75277;
        Mon, 24 Apr 2023 19:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=yvvAiIm6WAF/ZnuR2Pfm/PA+0eucp8BHbgJIK84QU4I=; b=lYV2bEQrA2T6jAuYvkideVmzfX
        g3Skb4sGNC7XEuqHSWIFmIhJDBMh41h6zfTsKw88qqHj5UHFoVict3uDsfOvD7+Ske9pImu+f+/xK
        9zXbaXgOGPeGHM9Z1jgJUWck9sN1VLKccvRDu0Ozuo7eaDrwS/Gl8kvRCrijp18U2biLI3I8K1bvn
        dV0Ffg/6bOUiPMEDeAfnjI3bFuOh6fwECnoB9JpGpcuaEU2hOumIphipoj/BVk4ocrWPrAuO9eHTX
        EwjgJEALnkEMGt+QFVj5aAzQCtbO8P4B1fhsvFlXvdbOGivL4G1zVYGsZeRrSdyXBeiC0SRU2WLNg
        8jgHocZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pr8WO-00CIR4-06;
        Tue, 25 Apr 2023 02:35:12 +0000
Date:   Tue, 25 Apr 2023 03:35:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] the rest of write_one_page() series
Message-ID: <20230425023511.GO3390869@ZenIV>
References: <20230424042638.GJ3390869@ZenIV>
 <CAHk-=wibAWqh3JqWaWfi=JWNAz3v_qb7LZ+76qF+PKEJciHbGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wibAWqh3JqWaWfi=JWNAz3v_qb7LZ+76qF+PKEJciHbGA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 07:24:05PM -0700, Linus Torvalds wrote:
> On Sun, Apr 23, 2023 at 9:26 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > write_one_page series
> 
> Hmm. These pull requests really could have done with better descriptions.
> 
> Yes, I see what it's doing, but I'd really like to have better merge
> messages from the pull request.

Point...  With this one it would be along the lines of "the parts of
Christoph's write_one_page() elimination series that missed the previous
merge window".

pull-fd: "routine whack-a-mole for new unwarranted callers of fget() that
really ought to have been using fdget() - that kind of stuff keeps
cropping up and needs to be hunted down once in a while".

pull-old_dio: "For a while fs/direct-io.c had been trying to keep up with
filesystems' demands; eventually the tricky cases started to convert to
iomap-based variant, so some of the stuff added for e.g. btrfs sake had
become unused.  Longer term we want to get rid of fs/direct-io.c completely,
but for now let's at least undo some of the now-useless complexity there"

pull-nios2, pull-misc: really can't improve the descriptions in those...
