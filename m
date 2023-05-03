Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99FC6F5EEE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 21:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjECTK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 15:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECTK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 15:10:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C3610FE;
        Wed,  3 May 2023 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=yVZFBajLG2Ccr5ofun2l+j34TQq7wWP4t6HjopGH8GY=; b=MnqLRCMk2UYC0BAym+TcMZaQjA
        yoCgJbJwN1wHF4QU2BvfsesT1WPXAkpQKwEYh6SWJTJ860dmt95ENmQUfGEW4HrxFJnb51KeT3XFa
        mvfXNRrD766mowX57z3YFCInWRnVZh4tNqbOM21c1EjxXi0kTBtKaMsYny3gfg0UJNOty6uW+NtTS
        UDg0dBdQ4bznl4YEQ91AIPRhDjKCXSN2sd0w2TKIJ5o5+HARvGGmW6G8UaYaVG9CAMlD5rJCzaWSt
        epEt2tEVBaLEHUn6dOm/TukmfZbum1mf5CODR4hMruwP42EfAQRzJ0AHt1CMoiCRJRmMfAbwB/ahv
        PxBrlj+w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1puHrj-005YD5-2W;
        Wed, 03 May 2023 19:10:15 +0000
Date:   Wed, 3 May 2023 12:10:15 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        ebiggers@kernel.org, jeffxu@google.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sysctl: death to register_sysctl_paths()
Message-ID: <ZFKxl2d+kqYN0ohG@bombadil.infradead.org>
References: <20230503023329.752123-1-mcgrof@kernel.org>
 <ZFKKpQdx4nO8gWUT@bombadil.infradead.org>
 <CAHk-=whGT-jpLRH_W+k-WP=VghAVa7wRfULg=KWhpxiVofsn0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whGT-jpLRH_W+k-WP=VghAVa7wRfULg=KWhpxiVofsn0Q@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 11:29:10AM -0700, Linus Torvalds wrote:
> On Wed, May 3, 2023 at 9:24 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Tue, May 02, 2023 at 07:33:27PM -0700, Luis Chamberlain wrote:
> > > You can give it a day for a warm fuzzy build test result.
> >
> > 0-day gives its blessings.
> 
> Well, it's not like I can pull anyway, since you didn't actually say
> where to pull *from*. And I don't want to randomly apply patches when
> I know you have a git tree for this.
> 
> So please do a proper pull request.

Sorry thought you don't mind a few patches, so ditched the formalities
for the pull. Now I know you prefer to pull over a couple of patches,
will send up next!

  Luis
