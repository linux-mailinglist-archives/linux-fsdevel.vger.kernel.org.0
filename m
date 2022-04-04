Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D874F1EB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 00:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346181AbiDDVzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386879AbiDDVmq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:42:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AA447AE6;
        Mon,  4 Apr 2022 14:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 160E961440;
        Mon,  4 Apr 2022 21:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CAAC340F2;
        Mon,  4 Apr 2022 21:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649108084;
        bh=YdNEVsu2vhs3xxB40qnalEJQ3Tm1WmXEE+qRFYPcoPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yNNEC3dEgvezI1DPr4jLVBP/ljenhzUyu9RCMHvYyHpCGlCMlrEJkHl2dRJU1EGtg
         Pxouf7f7NyvfFm+CgxBTfhE7IIsc7pa1fevgUP/9SmbmQHNdyTCCA8VXnIMlsdvy6J
         RjwWF/yNE81TAqizDpAsAe3hc7Gg6pHgOmauxTsA=
Date:   Mon, 4 Apr 2022 14:34:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, yangtiezhu@loongson.cn,
        amit.kachhap@arm.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 0/3] Convert vmcore to use an iov_iter
Message-Id: <20220404143443.2258fc7e97b45172f7608a77@linux-foundation.org>
In-Reply-To: <20220402043008.458679-1-bhe@redhat.com>
References: <20220402043008.458679-1-bhe@redhat.com>
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

> On Sat,  2 Apr 2022 12:30:05 +0800 Baoquan He <bhe@redhat.com> wrote:

You were on the patch delivery path, so these patches should have had
your signoff.  Documentation/process/submitting-patches.rst explains.

> Copy the description of v3 cover letter from Willy:
> ===
> For some reason several people have been sending bad patches to fix
> compiler warnings in vmcore recently.  Here's how it should be done.
> Compile-tested only on x86.  As noted in the first patch, s390 should
> take this conversion a bit further, but I'm not inclined to do that
> work myself.

We should tell the S390 maintainers this!

Can you please fix the signoff issue, add the S390 team to Cc and resend?
