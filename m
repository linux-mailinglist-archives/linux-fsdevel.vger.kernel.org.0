Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1E6708E37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 05:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjESDQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 23:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjESDQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 23:16:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB6A6
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 20:16:07 -0700 (PDT)
Received: from letrec.thunk.org (c-73-212-78-46.hsd1.md.comcast.net [73.212.78.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34J3FOqn029941
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 23:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684466129; bh=jwhdipxRwt17VHbkfp65xNv4jLc8Jh1vnKtY8iZIs10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kzCtQPMt8l1BwbiAE9yr4l8nYcawVAQ1Zz4TYBxHBJWw5P/THc92BWQfvAn9g0Ss3
         QS17GFNOM49utdmWCO0YbsW5EbM2QQ+vU4T1CfVNhwhKT1ZyvAg/4yU5SqQr8JsC2L
         ahId2PBad1g0pWY5MEqCvA4rbOa9bEXCv5joGiZYYsYC104CYf7zb97W2n0k2Crg33
         K3/VbZS+Vfqc+B0CDBL4rf1sjv0iaOXMumEQ8dQHbOgzLUU8PuF+1A0CuAWSzR+UWn
         l0aLKcioCLKN+qC5IWci+bIZar6hek3GzdmjttpkVAqI/Rg82UcOcK1YetiQ8V5eOY
         7NIHC2wkVAqyw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 358158C02F5; Thu, 18 May 2023 23:15:24 -0400 (EDT)
Date:   Thu, 18 May 2023 23:15:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, corbet@lwn.net, jake@lwn.net,
        djwong@kernel.org, dchinner@redhat.com, ritesh.list@gmail.com,
        rgoldwyn@suse.com, jack@suse.cz, linux-doc@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, rohan.puri@samsung.com
Subject: Re: [PATCH] Documentation: add initial iomap kdoc
Message-ID: <ZGbpzBIZHBqgmTbz@mit.edu>
References: <20230518144037.3149361-1-mcgrof@kernel.org>
 <ZGY61jQfExQc2j71@infradead.org>
 <ZGY7G8gIvWCi0ONT@bombadil.infradead.org>
 <ZGY7aumgDgU0jIK0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGY7aumgDgU0jIK0@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 07:51:22AM -0700, Christoph Hellwig wrote:
> On Thu, May 18, 2023 at 07:50:03AM -0700, Luis Chamberlain wrote:
> > On Thu, May 18, 2023 at 07:48:54AM -0700, Christoph Hellwig wrote:
> > > > +**iomap** allows filesystems to query storage media for data using *byte ranges*. Since block
> > > > +mapping are provided for a *byte ranges* for cache data in memory, in the page cache, naturally
> > > 
> > > Without fixing your line length I can't even read this mess..
> > 
> > I thought we are at 100?
> 
> Ony for individual lines and when it improves readability (whatever
> that means).  But multiple to long lines, especially full of text
> are completely unreadable in a terminal.

For C code, if you have really deeply nested code, sometimes it's
better to have some lines which are longer than to have gratuitous
line break just to keep everything under 72-76 characters.

But if you are writing a block of text, and you are expecting people
to read it in a terminal window, I think it is adviseable to wrap at
72 characters.  In fact, some will advise wrapping earlier than that,
to better aid comprehension.  For example:

   "Optimal line length or column width for body text is 40–70
   characters.  When people read, their eyes jump across a line of
   text, pausing momentarily to take in groups of three or four
   words. Studies have shown that readers can make only three or four
   of these jumps (or saccades) per line before reading becomes
   tiring.

   Too long lines with too many words also make it harder for the eyes
   to find the correct spot when they sweep back to the left to pick
   up the next line of text. To maintain readability, it is imperative
   to use moderate line lengths within the range of 40–70 characters.

   Do not set normally sized body text in a single column across a 8.5
   by 11 inch page. If you do that, the result will greatly exceed 70
   characters, reading efficiency will be significantly reduced, and
   your readers’ attention will be easily lost.

   Two column layouts are the best solution for achieving optimal body
   text column widths on American letter size paper. If that is not
   practical and using only one column is necessary, then be sure to
   use large side margins in order to bring the line length as close
   as possible to 70 characters or less."

   -- https://winterpm.com/

Cheers,

						- Ted
