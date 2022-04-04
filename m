Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815F44F2010
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 01:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbiDDXPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 19:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243154AbiDDXOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:14:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8971E24BD8;
        Mon,  4 Apr 2022 15:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 482E0B819DE;
        Mon,  4 Apr 2022 22:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B060DC2BBE4;
        Mon,  4 Apr 2022 22:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649112918;
        bh=YJPKmsV50zrBbXBnSBP0IPEb8ro9ZtjvwhW0Jj1bEm8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pMccEIrlU08djbT7wpa1ZN4nuH6BttjslEaHrMrXBm3RIBKlSfoT0f/FcYT2iS3ls
         IYcRnNyMZ2Ls6Geib4sGfeWHOyVNPrHRYk5vsSDvKGz4SQVWlct+pYgglSnVLUFkJ2
         f9M0YKMLgA0eGO3o2jNb33HftQnjOIzmrwYzIOVU=
Date:   Mon, 4 Apr 2022 15:55:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] fs/proc/kcore.c: remove check of list iterator against
 head past the loop body
Message-Id: <20220404155516.a5fb4c23ee017a7212e4b22c@linux-foundation.org>
In-Reply-To: <A23914B0-BFD7-48D6-ADCF-42062E1D9887@gmail.com>
References: <20220331223700.902556-1-jakobkoschel@gmail.com>
        <20220331164843.b531fbf00d6e7afd6cdfe113@linux-foundation.org>
        <A23914B0-BFD7-48D6-ADCF-42062E1D9887@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 1 Apr 2022 09:19:57 +0200 Jakob Koschel <jakobkoschel@gmail.com> wrote:

> > Speaking of limiting scope...
> 
> Fair point :-)
> 
> I see you have applied this already to the -mm tree. Shall I still move the iterator?
> The hope is to remove the 'iter' variable altogether when there are no uses after
> the loop anymore.

I don't really understand the question.

My plan is to merge your patch with my fixlet immediately prior to
sending upstream.

