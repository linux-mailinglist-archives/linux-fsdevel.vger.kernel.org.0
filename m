Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D108598955
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 18:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345074AbiHRQuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345188AbiHRQue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:50:34 -0400
Received: from hop.stappers.nl (hop.stappers.nl [IPv6:2a02:2308:0:14e::686f:7030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25342DFC8;
        Thu, 18 Aug 2022 09:50:29 -0700 (PDT)
Received: from gpm.stappers.nl (gpm.stappers.nl [IPv6:2a02:a46d:659e:1::696e:626f])
        by hop.stappers.nl (Postfix) with ESMTP id 0F5DB200C8;
        Thu, 18 Aug 2022 16:50:27 +0000 (UTC)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
        id B118C304049; Thu, 18 Aug 2022 18:50:26 +0200 (CEST)
Date:   Thu, 18 Aug 2022 18:50:26 +0200
From:   Geert Stappers <stappers@stappers.nl>
To:     Kees Cook <keescook@chromium.org>, Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v9 02/27] kallsyms: avoid hardcoding buffer size
Message-ID: <20220818165025.ighwic3zqe2xh6be@gpm.stappers.nl>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-3-ojeda@kernel.org>
 <202208171236.9CA3B9D579@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208171236.9CA3B9D579@keescook>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:37:40PM -0700, Kees Cook wrote:
> On Fri, Aug 05, 2022 at 05:41:47PM +0200, Miguel Ojeda wrote:
> > From: Boqun Feng <boqun.feng@gmail.com>
> > 
> > This introduces `KSYM_NAME_LEN_BUFFER` in place of the previously
> > hardcoded size of the input buffer.
> > 
> > It will also make it easier to update the size in a single place
> > in a later patch.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Does someone want to commit to taking these "prereq" patches? These
> clean-ups are nice even without adding Rust.

Qouting Message-ID: <CANiq72mXDne_WkUCo2oRe+sip7nQWESnouOJrcCYzyJMkG8F6A@mail.gmail.com>
https://lore.kernel.org/lkml/CANiq72mXDne_WkUCo2oRe+sip7nQWESnouOJrcCYzyJMkG8F6A@mail.gmail.com/
Miguel Ojeda, 2022-08-05: 
| > And I think that this patch and all other "rust" kallsyms patches
| > allready should have been accepted in the v3 or v5 series.
| 
| Yeah, it could be a good idea to get the prerequisites in first.
| Let's see if the patches get some Reviewed-bys

Now that there is a 'Reviewed-by: Kees Cook <keescook@chromium.org>'


Regards
Geert Stappers
In an attempt to help making Rust for Linux happen.
-- 
Silence is hard to parse
