Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FD879BF5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbjIKUxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244082AbjIKTD7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:03:59 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DD1DB
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1694459030;
        bh=5AvBVXwbkkod10a/5EG2d/zEeWlAiJtQeNJz/f07Xvk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=uGlXnqbyJUv+WppXTXaGItNVK9UFhi8czcKG0kf04tR8M/IQgqC8jkam0TkrPRT9Q
         83Fw55LrKyR/6IAl/7XkDC6UHJHX2dj5B2TvpS3ADC7hRKg2rk04p3yknUh9IGLCj2
         DO/m1G+zUTTJ9D7qVgghLchsuWB7IpnFgqOk/wvU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E797C1285F3A;
        Mon, 11 Sep 2023 15:03:50 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 7hNSTzYXy-wG; Mon, 11 Sep 2023 15:03:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1694459030;
        bh=5AvBVXwbkkod10a/5EG2d/zEeWlAiJtQeNJz/f07Xvk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=uGlXnqbyJUv+WppXTXaGItNVK9UFhi8czcKG0kf04tR8M/IQgqC8jkam0TkrPRT9Q
         83Fw55LrKyR/6IAl/7XkDC6UHJHX2dj5B2TvpS3ADC7hRKg2rk04p3yknUh9IGLCj2
         DO/m1G+zUTTJ9D7qVgghLchsuWB7IpnFgqOk/wvU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 699E01285F31;
        Mon, 11 Sep 2023 15:03:49 -0400 (EDT)
Message-ID: <5dd21470139df5de7f02608f453469023f50d704.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file
 systems
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 11 Sep 2023 15:03:45 -0400
In-Reply-To: <20230911031015.GF701295@mit.edu>
References: <ZO9NK0FchtYjOuIH@infradead.org>
         <ZPe0bSW10Gj7rvAW@dread.disaster.area>
         <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
         <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
         <ZPyS4J55gV8DBn8x@casper.infradead.org>
         <a21038464ad0afd5dfb88355e1c244152db9b8da.camel@HansenPartnership.com>
         <20230911031015.GF701295@mit.edu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2023-09-10 at 23:10 -0400, Theodore Ts'o wrote:
> On Sun, Sep 10, 2023 at 03:51:42PM -0400, James Bottomley wrote:
[...]
> > Perhaps we should also go back to seeing if we can prize some
> > resources out of the major moneymakers in the cloud space.  After
> > all, a bug that could cause a cloud exploit might not be even
> > exploitable on a personal laptop that has no untrusted users.
> 
> Actually, I'd say this is backwards.  Many of these issues, and I'd
> argue all that involve an maliciously corrupted file system, are not
> actually an issue in the cloud space, because we *already* assume
> that the attacker may have root.  After all, anyone can pay their $5
> CPU/hour, and get an Amazon or Google or Azure VM, and then run
> arbitrary workloads as root.

Well, that was just one example.  Another way cloud companies could
potentially help is their various AI projects: I seem to get daily
requests from AI people for me to tell them just how AI could help
Linux.  When I suggest bug report triage and classification would be my
number one thing, they all back off faster than a mouse crashing a cat
convention with claims like "That's too hard a problem" and also that
in spite of ChatGPT getting its facts wrong and spewing rubbish for
student essays, it wouldn't survive the embarrassment of being
ridiculed by kernel developers for misclassifying bug reports.

I'm not sure peer pressure works on the AI community, but surely if
enough of us asked, they might one day overcome their fear of trying it
...

James

