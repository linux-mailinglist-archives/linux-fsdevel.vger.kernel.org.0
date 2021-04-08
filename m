Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA25135894A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 18:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhDHQJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 12:09:09 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47135 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231655AbhDHQJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:09:07 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A7F145C00DF;
        Thu,  8 Apr 2021 12:08:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 08 Apr 2021 12:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=mC9lT507J6RIj+U5nS4hMawdjll
        gWQu3AF4sHZo0txk=; b=ftKoFL1DidJZ8AA4UiXRBaU5Tu/vdy4sOfZHQQmhepU
        HFTbJRcZk4OJYHb7DXNl1OHOgfJGsD0r8tiXXEeY730VTP+oE0SnZy8Y1GVsNKXw
        bLI4yQ8/J2guhtUHQIUQYA3dKLYMe+7xf9I4FGT1eVdicvUi05vrxgSzIH4HIMdV
        +4KJ+4o6qNs4r/AAmuWFKgdyTGY5ltllEXKqhmP/FzQOY2YCIw2GguWbUAkqhS3t
        mxlWlEa/p/Efv/FKnhlcqtbnEVEKepAyYZL+GXFx7r+pFIH+J+8tlk8pEd8Mm/TL
        RBiv9VPfKNNj2SrCDhrrbjjz9sHMFJz4Blvr+seB0Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=mC9lT5
        07J6RIj+U5nS4hMawdjllgWQu3AF4sHZo0txk=; b=QuGYtViLn86Ts9x5v5g3bd
        MVi95Jp1JOot0EuVp4/oK46YOgRBpnkpsxCK05+VilcbR8CjelhsaBupaZBiRqD8
        36+6xejpOF86GaFL9DZuhdR8GnQQFT5peUrpzpelRPcS+LLYFBtu7oaB699rpKmE
        7+Uh9cL5tIZfJQNmxEFuTLdprT8MUmC9RKgt9d+vY0LmiaePWIwrPwGzoTS203cl
        Y1o8ujJmjsrczLBw+KMiHiLNsAS93ogs+fciMCd80KEdPYJXq/NYdo6A8dcnMUKk
        naDGagrYNcCUX/44wxC3Ri2u59NRTLRQxY58nNlL+6Ka80F/GNZLHrWIRm0/KUvg
        ==
X-ME-Sender: <xms:lipvYF7SfN6hNym_9V4OYOWn5Okx7dgtJvSqli_dhA_3bMhvaYuzpQ>
    <xme:lipvYC4ixJoGnA6Q4ZMtsIzXcY2Mz-WPG0Y-5hO75A8cWwkXfE0aCUr0oCdUT4MOA
    6RtxjdXZuaZgzdGlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpeeuuddvjeefffelgfeuveehfeegfeetfeetueduudfhudfhheev
    leetveduleehjeenucfkphepudeifedruddugedrudefvddrheenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:lipvYMc5AHrO0bJ0YYtZHVOA4DkPwEazneQcBEkIV7VVW6bNzgcuBw>
    <xmx:lipvYOLPWECCm__gGzjEHGj6wLfKS4p75juNqctycEiUFlqiOzHtJg>
    <xmx:lipvYJJTMQ19BjHxkt47O7443iOtPuOcbWY1ImfKIH5cnKE5lMQlvA>
    <xmx:lypvYB-LW7W04XNfwu0IrGh4H4juFXqHfL4louBnMaazNjISkn_FOg>
Received: from dlxu-fedora-R90QNFJV (unknown [163.114.132.5])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9C2731080054;
        Thu,  8 Apr 2021 12:08:53 -0400 (EDT)
Date:   Thu, 8 Apr 2021 09:08:37 -0700
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com
Subject: Re: [RFC bpf-next 0/1] bpf: Add page cache iterator
Message-ID: <20210408160837.kbqxe3ls6ogjvayc@dlxu-fedora-R90QNFJV>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
 <20210408075117.oqoqspilk3c3xsaa@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408075117.oqoqspilk3c3xsaa@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian, thanks for taking a look.

On Thu, Apr 08, 2021 at 09:51:17AM +0200, Christian Brauner wrote:
> On Wed, Apr 07, 2021 at 02:46:10PM -0700, Daniel Xu wrote:
> > There currently does not exist a way to answer the question: "What is in
> > the page cache?". There are various heuristics and counters but nothing
> > that can tell you anything like:
> > 
> >   * 3M from /home/dxu/foo.txt
> >   * 5K from ...
> >   * etc.
> > 
> > The answer to the question is particularly useful in the stacked
> > container world. Stacked containers implies multiple containers are run
> > on the same physical host. Memory is precious resource on some (if not
> 
> Just to clarify: what are "stacked containers"? Do you mean nested
> containers, i.e. containers running within containers?

I mean multiple containers running side by side on the same host.

Thanks,
Daniel
